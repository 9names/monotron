use super::{api, Context, APPLICATION_RAM, FRAMEBUFFER};
use core::fmt::Write;
use embedded_hal::prelude::*;
use fb::{self, BaseConsole};
use menu;
use demos;

pub(crate) type Menu<'a> = menu::Menu<'a, Context>;
pub(crate) type Item<'a> = menu::Item<'a, Context>;

const TEST_ALPHABET: Item = Item {
    item_type: menu::ItemType::Callback(demos::test_alphabet),
    command: "alphabet",
    help: Some("Scrolls some test text output."),
};

const TEST_CLEAR: Item = Item {
    item_type: menu::ItemType::Callback(test_clear),
    command: "clear",
    help: Some("Resets the display."),
};

const TEST_ANIMATION: Item = Item {
    item_type: menu::ItemType::Callback(demos::test_animation),
    command: "animate",
    help: Some("Bounces argument around."),
};

const TEST_ART: Item = Item {
    item_type: menu::ItemType::Callback(demos::test_art),
    command: "art",
    help: Some("Show some art."),
};

const ITEM_PEEK: Item = Item {
    item_type: menu::ItemType::Callback(item_peek),
    command: "peek",
    help: Some("<addr> - Read a register."),
};

const ITEM_POKE: Item = Item {
    item_type: menu::ItemType::Callback(item_poke),
    command: "poke",
    help: Some("<addr> <value> - Write a register."),
};

const ITEM_DUMP: Item = Item {
    item_type: menu::ItemType::Callback(item_dump),
    command: "dump",
    help: Some("<addr> <bytes> - Dump RAM/ROM."),
};

const ITEM_LOAD: Item = Item {
    item_type: menu::ItemType::Callback(load_file),
    command: "load",
    help: Some("<len> - Load program from UART."),
};

const ITEM_DEBUG: Item = Item {
    item_type: menu::ItemType::Callback(debug_info),
    command: "debug",
    help: Some("- Show some debug info."),
};

const ITEM_RUN: Item = Item {
    item_type: menu::ItemType::Callback(run_program),
    command: "run",
    help: Some("Run loaded program."),
};

pub(crate) const ROOT_MENU: Menu = Menu {
    label: "root",
    items: &[
        &TEST_ALPHABET,
        &TEST_ANIMATION,
        &TEST_ART,
        &TEST_CLEAR,
        &ITEM_PEEK,
        &ITEM_POKE,
        &ITEM_DUMP,
        &ITEM_LOAD,
        &ITEM_RUN,
        &ITEM_DEBUG,
    ],
    entry: None,
    exit: None,
};

/// Clears the screen
fn test_clear<'a>(_menu: &Menu, _item: &Item, _input: &str, _context: &mut Context) {
    unsafe { FRAMEBUFFER.clear() };
    unsafe { FRAMEBUFFER.set_pos(fb::Position::origin()).unwrap() };
}

fn item_peek<'a>(_menu: &Menu, _item: &Item, input: &str, context: &mut Context) {
    let mut parts = input.split_whitespace();
    parts.next();
    if let Some(addr) = parts
        .next()
        .map_or(None, |p| usize::from_str_radix(p, 16).ok())
    {
        unsafe {
            let data = ::core::ptr::read_volatile(addr as *const u32);
            writeln!(context, "Addr 0x{:08x} is 0x{:08x}", addr, data).unwrap();
        }
    } else {
        writeln!(
            context,
            "Bad address {:?}. Enter hex, without the 0x prefix..",
            input
        ).unwrap();
    }
}

fn item_poke<'a>(_menu: &Menu, _item: &Item, input: &str, context: &mut Context) {
    let mut parts = input.split_whitespace();
    parts.next();
    if let Some(addr) = parts
        .next()
        .map_or(None, |p| usize::from_str_radix(p, 16).ok())
    {
        if let Some(value) = parts
            .next()
            .map_or(None, |p| u32::from_str_radix(p, 16).ok())
        {
            writeln!(context, "Poking 0x{:08x} to addr 0x{:08x}...", value, addr).unwrap();
            unsafe {
                ::core::ptr::write_volatile(addr as *mut u32, value);
            }
        } else {
            writeln!(context, "Missing or bad value.").unwrap();
        }
    } else {
        writeln!(context, "Missing or bad address.").unwrap();
    }
}

fn item_dump<'a>(_menu: &Menu, _item: &Item, input: &str, context: &mut Context) {
    let mut parts = input.split_whitespace();
    parts.next();
    if let Some(mut addr) = parts
        .next()
        .map_or(None, |p| usize::from_str_radix(p, 16).ok())
    {
        if let Some(count) = parts
            .next()
            .map_or(None, |p| u32::from_str_radix(p, 16).ok())
        {
            writeln!(
                context,
                "Dumping 0x{:08x} bytes from 0x{:08x}...",
                count, addr
            ).unwrap();
            for i in 0..count {
                let data = unsafe { ::core::ptr::read_volatile(addr as *const u8) };
                write!(context, "{:02x}", data).unwrap();
                if ((i + 1) % 4) == 0 {
                    write!(context, " ").unwrap();
                }
                if ((i + 1) % 16) == 0 {
                    write!(context, "\n").unwrap();
                }
                addr += 1;
            }
            writeln!(context, "\nDone.").unwrap();
        } else {
            writeln!(context, "Missing or bad value.").unwrap();
        }
    } else {
        writeln!(context, "Missing or bad address.").unwrap();
    }
}

/// Reads raw binary from the UART and dumps it into application RAM.
fn load_file<'a>(_menu: &Menu, _item: &Item, _input: &str, context: &mut Context) {
    unsafe {
        for b in APPLICATION_RAM.iter_mut() {
            *b = 0x00;
        }
    }
    writeln!(context, "Reading hex...").unwrap();
    let mut i = 0;
    let max_bytes = unsafe { APPLICATION_RAM.len() };
    while i < max_bytes {
        let ch = loop {
            match context.rx.read() {
                Ok(x) => break x,
                _ => {}
            }
        };
        let mut byte = match ch {
            b'0' => 0x00,
            b'1' => 0x10,
            b'2' => 0x20,
            b'3' => 0x30,
            b'4' => 0x40,
            b'5' => 0x50,
            b'6' => 0x60,
            b'7' => 0x70,
            b'8' => 0x80,
            b'9' => 0x90,
            b'A' => 0xA0,
            b'B' => 0xB0,
            b'C' => 0xC0,
            b'D' => 0xD0,
            b'E' => 0xE0,
            b'F' => 0xF0,
            b'a' => 0xA0,
            b'b' => 0xB0,
            b'c' => 0xC0,
            b'd' => 0xD0,
            b'e' => 0xE0,
            b'f' => 0xF0,
            _ => return,
        };
        let ch = loop {
            match context.rx.read() {
                Ok(x) => break x,
                _ => {}
            }
        };
        byte |= match ch {
            b'0' => 0x00,
            b'1' => 0x01,
            b'2' => 0x02,
            b'3' => 0x03,
            b'4' => 0x04,
            b'5' => 0x05,
            b'6' => 0x06,
            b'7' => 0x07,
            b'8' => 0x08,
            b'9' => 0x09,
            b'A' => 0x0A,
            b'B' => 0x0B,
            b'C' => 0x0C,
            b'D' => 0x0D,
            b'E' => 0x0E,
            b'F' => 0x0F,
            b'a' => 0x0A,
            b'b' => 0x0B,
            b'c' => 0x0C,
            b'd' => 0x0D,
            b'e' => 0x0E,
            b'f' => 0x0F,
            _ => return,
        };
        unsafe {
            APPLICATION_RAM[i] = byte;
        }
        i = i + 1;
    }
}

/// Print some debug info.
fn debug_info<'a>(_menu: &Menu, _item: &Item, _input: &str, context: &mut Context) {
    let fb_addr = unsafe { &FRAMEBUFFER as *const _ } as usize;
    let app_addr = unsafe { &APPLICATION_RAM as *const _ } as usize;
    writeln!(context, "Framebuffer: 0x{:08x}", fb_addr).unwrap();
    writeln!(context, "Application: 0x{:08x}", app_addr).unwrap();
}

/// Runs a program from application RAM, then returns.
fn run_program<'a>(_menu: &Menu, _item: &Item, _input: &str, context: &mut Context) {
    unsafe {
        let addr = ((APPLICATION_RAM[3] as u32) << 24)
            | ((APPLICATION_RAM[2] as u32) << 16)
            | ((APPLICATION_RAM[1] as u32) << 8)
            | ((APPLICATION_RAM[0] as u32) << 0);
        writeln!(context, "Executing from 0x{:08x}", addr).unwrap();

        // struct callbacks_t {
        //     void* p_context;
        //     int32_t(*putchar)(char ch);
        //     int32_t(*puts)(const char*);
        //     int32_t(*readc)(void* p_context);
        //     int32_t(*wfvbi)(void* p_context);
        //     int32_t(*kbhit)(void* p_context);
        // };

        #[repr(C)]
        struct Table {
            context: *mut Context,
            putchar: extern "C" fn(*mut Context, u8) -> i32,
            puts: extern "C" fn(*mut Context, *const u8) -> i32,
            readc: extern "C" fn(*mut Context) -> i32,
            wfvbi: extern "C" fn(*mut Context),
            kbhit: extern "C" fn(*mut Context) -> i32,
        }
        let t = Table {
            context: context as *mut Context,
            putchar: api::putchar,
            puts: api::puts,
            readc: api::readc,
            wfvbi: api::wfvbi,
            kbhit: api::kbhit,
        };
        let ptr = addr as *const ();
        let code: extern "C" fn(*const Table) -> u32 = ::core::mem::transmute(ptr);
        let result = code(&t);
        writeln!(context, "Result: {}", result);
    }
}

// End of file
use crate::fb::{self, AsciiConsole, BaseConsole};
use crate::hal::prelude::*;
use crate::MenuContext;
use crate::GLOBAL_CONTEXT;
use crate::{api, Context, Input, APPLICATION_LEN, APPLICATION_START_ADDR, FRAMEBUFFER};
use crate::{print, println};
use embedded_hal::prelude::*;
use menu;

pub(crate) type Menu<'a> = menu::Menu<'a, MenuContext>;
pub(crate) type Item<'a> = menu::Item<'a, MenuContext>;

pub(crate) static ROOT_MENU: Menu = Menu {
    label: "root",
    items: &[
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_clear,
                parameters: &[],
            },
            command: "clear",
            help: Some("Reset the display."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_peek,
                parameters: &[menu::Parameter::Mandatory {
                    parameter_name: "ADDRESS",
                    help: Some("The address to read from."),
                }],
            },
            command: "peek",
            help: Some("Read from memory."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_poke,
                parameters: &[
                    menu::Parameter::Mandatory {
                        parameter_name: "ADDRESS",
                        help: Some("The address to write to."),
                    },
                    menu::Parameter::Mandatory {
                        parameter_name: "VALUE",
                        help: Some("The 32-bit value to write."),
                    },
                ],
            },
            command: "poke",
            help: Some("Write to memory."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_dump,
                parameters: &[
                    menu::Parameter::Mandatory {
                        parameter_name: "ADDRESS",
                        help: Some("The address to start at."),
                    },
                    menu::Parameter::NamedValue {
                        parameter_name: "length",
                        argument_name: "BYTES",
                        help: Some("The number of bytes to display."),
                    },
                ],
            },
            command: "dump",
            help: Some("Display memory contents."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_load_from_uart,
                parameters: &[],
            },
            command: "load",
            help: Some("Load from UART."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_debug_info,
                parameters: &[],
            },
            command: "debug",
            help: Some("Show some debug."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_run_program,
                parameters: &[],
            },
            command: "run",
            help: Some("Run program."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_beep,
                parameters: &[
                    menu::Parameter::NamedValue {
                        parameter_name: "wave",
                        argument_name: "X",
                        help: Some("The shape of the waveform to play."),
                    },
                    menu::Parameter::NamedValue {
                        parameter_name: "len",
                        argument_name: "N",
                        help: Some("The length of the beep in frames."),
                    },
                    menu::Parameter::NamedValue {
                        parameter_name: "freq",
                        argument_name: "HZ",
                        help: Some("The pitch of the beep in Hz."),
                    },
                    menu::Parameter::NamedValue {
                        parameter_name: "chan",
                        argument_name: "N",
                        help: Some("The channel (0, 1 or 2)."),
                    },
                ],
            },
            command: "beep",
            help: Some("Make a beep."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_mount,
                parameters: &[],
            },
            command: "mount",
            help: Some("Mount the SD card."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_unmount,
                parameters: &[],
            },
            command: "unmount",
            help: Some("Unmount the SD card."),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_dir,
                parameters: &[],
            },
            command: "dir",
            help: Some("List the root dir"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_dload,
                parameters: &[menu::Parameter::Mandatory {
                    parameter_name: "FILE",
                    help: Some("The file to load."),
                }],
            },
            command: "dload",
            help: Some("Load file from SD card"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_ddump,
                parameters: &[],
            },
            command: "ddump",
            help: Some("Hexdump a file"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: item_dpage,
                parameters: &[],
            },
            command: "dpage",
            help: Some("Show a text file"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: rs232_term,
                parameters: &[menu::Parameter::NamedValue {
                    parameter_name: "bitrate",
                    argument_name: "BPS",
                    help: Some("The bit rate for the UART - typically 115200."),
                }],
            },
            command: "rterm",
            help: Some("RS232 serial terminal"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: midi_term,
                parameters: &[],
            },
            command: "mterm",
            help: Some("MIDI debug terminal"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: i2c_rx,
                parameters: &[
                    menu::Parameter::Mandatory {
                        parameter_name: "ADDR",
                        help: Some("The 7-bit I2C device address"),
                    },
                    menu::Parameter::Mandatory {
                        parameter_name: "REG",
                        help: Some("The register number to read from the device"),
                    },
                    menu::Parameter::Mandatory {
                        parameter_name: "N",
                        help: Some("The number of bytes to read from the register"),
                    },
                ],
            },
            command: "i2c_rx",
            help: Some("Read from I2C device"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: i2c_tx,
                parameters: &[
                    menu::Parameter::Mandatory {
                        parameter_name: "ADDR",
                        help: Some("The 7-bit I2C device address"),
                    },
                    menu::Parameter::Mandatory {
                        parameter_name: "REG",
                        help: Some("The register number to write to on the device"),
                    },
                    menu::Parameter::Mandatory {
                        parameter_name: "BYTE",
                        help: Some("A single byte to write to the register"),
                    },
                ],
            },
            command: "i2c_tx",
            help: Some("Write to I2C device"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: charset,
                parameters: &[],
            },
            command: "charset",
            help: Some("Shows the character set"),
        },
        &Item {
            item_type: menu::ItemType::Callback {
                function: date,
                parameters: &[menu::Parameter::Optional {
                    parameter_name: "TIMESTAMP",
                    help: Some("The date/time string in YYYY-MM-DDTHH:MM:SS format"),
                }],
            },
            command: "date",
            help: Some("Get/set the date/time"),
        },
    ],
    entry: None,
    exit: None,
};

/// Clears the screen
fn item_clear<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    unsafe { FRAMEBUFFER.clear() };
    unsafe { FRAMEBUFFER.set_pos(fb::Position::origin()).unwrap() };
}

fn item_peek<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(addr) = ::menu::argument_finder(item, args, "ADDRESS")
        .unwrap()
        .map_or(None, |p| parse_u32(p))
    {
        let data = unsafe { ::core::ptr::read_volatile(addr as *const u32) };
        println!("Addr 0x{:08x} is 0x{:08x}", addr, data);
    } else {
        println!("Missing or bad address.");
    }
}

fn item_poke<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(addr) = ::menu::argument_finder(item, args, "ADDRESS")
        .unwrap()
        .map_or(None, |p| parse_u32(p))
    {
        if let Some(value) = ::menu::argument_finder(item, args, "VALUE")
            .unwrap()
            .map_or(None, |p| parse_u32(p))
        {
            println!("Poking 0x{:08x} to addr 0x{:08x}...", value, addr);
            unsafe {
                ::core::ptr::write_volatile(addr as *mut u32, value);
            }
        } else {
            println!("Missing or bad value.");
        }
    } else {
        println!("Missing or bad address.");
    }
}

fn item_dump<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(addr) = ::menu::argument_finder(item, args, "ADDRESS")
        .unwrap()
        .map_or(None, |p| parse_u32(p))
    {
        if let Some(length) = ::menu::argument_finder(item, args, "length")
            .unwrap_or(Some("16"))
            .map_or(None, |p| parse_u32(p))
        {
            let mut addr = addr;
            println!("Dumping 0x{:08x} bytes from 0x{:08x}...", length, addr);
            for i in 0..length {
                let data = unsafe { ::core::ptr::read_volatile(addr as *const u8) };
                print!("{:02x}", data);
                if ((i + 1) % 4) == 0 {
                    print!(" ");
                }
                if ((i + 1) % 16) == 0 {
                    print!("\n");
                }
                addr += 1;
            }
            println!("\nDone.");
        } else {
            println!("Missing or bad length.");
        }
    } else {
        println!("Missing or bad address.");
    }
}

/// Reads raw binary from the UART and dumps it into application RAM.
fn item_load_from_uart<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    let application_ram: &'static mut [u8] =
        unsafe { core::slice::from_raw_parts_mut(APPLICATION_START_ADDR, APPLICATION_LEN) };
    for b in application_ram.iter_mut() {
        *b = 0x00;
    }
    println!("Reading hex...");
    GLOBAL_CONTEXT
        .lock()
        .as_mut()
        .unwrap()
        .usb_uart
        .write_all(b"READY\r\n");
    let mut i = 0;
    let max_bytes = application_ram.len();
    const ACK_EVERY: usize = 4;
    let mut ack_count = 0;
    while i < max_bytes {
        let ch = loop {
            match GLOBAL_CONTEXT.lock().as_mut().unwrap().usb_uart.read() {
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
            _ => break,
        };
        let ch = loop {
            match GLOBAL_CONTEXT.lock().as_mut().unwrap().usb_uart.read() {
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
            _ => break,
        };
        application_ram[i] = byte;
        ack_count += 1;
        if ack_count >= ACK_EVERY {
            let _ = GLOBAL_CONTEXT.lock().as_mut().unwrap().usb_uart.write(b'X');
            ack_count = 0;
        }
        i = i + 1;
    }
    let digest = crc::crc32::checksum_ieee(&application_ram[0..i]);
    println!("Loaded {} bytes, CRC32 0x{:08x}", i, digest);
}

/// Print some debug info.
fn item_debug_info<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    println!("Framebuffer: {:08p}", unsafe { &FRAMEBUFFER as *const _ });
    println!("Application: {:08p}", APPLICATION_START_ADDR);
    println!("Chip:\n{:#?}", tm4c123x_hal::sysctl::chip_id::get());
}

/// Runs a program from application RAM, then returns.
fn item_run_program<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    let application_ram: &'static mut [u8] =
        unsafe { core::slice::from_raw_parts_mut(APPLICATION_START_ADDR, APPLICATION_LEN) };
    let addr = ((application_ram[3] as u32) << 24)
        | ((application_ram[2] as u32) << 16)
        | ((application_ram[1] as u32) << 8)
        | ((application_ram[0] as u32) << 0);
    println!("Executing from 0x{:08x}", addr);
    let ptr = addr as *const ();
    let result = unsafe {
        let code: extern "C" fn(*const api::Api) -> u32 = ::core::mem::transmute(ptr);
        code(&api::CALLBACK_TABLE)
    };
    unsafe {
        crate::G_SYNTH.play(
            monotron_synth::CHANNEL_0,
            monotron_synth::Frequency::from_hertz(440),
            0,
            monotron_synth::Waveform::Square,
        );
        crate::G_SYNTH.play(
            monotron_synth::CHANNEL_1,
            monotron_synth::Frequency::from_hertz(440),
            0,
            monotron_synth::Waveform::Square,
        );
        crate::G_SYNTH.play(
            monotron_synth::CHANNEL_2,
            monotron_synth::Frequency::from_hertz(440),
            0,
            monotron_synth::Waveform::Square,
        );
    }
    println!("\u{001B}W\u{001B}k\n\nResult: {}", result);
}

/// Makes a short beep.
///
/// The first argument sets the waveform (sine, sawtooth, square or noise).
/// The second sets the frequency (in Hz).
/// The third sets the duration (in 60Hz frames).
/// The fourth sets the channel.
fn item_beep<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    use monotron_synth::*;
    let waveform_arg = ::menu::argument_finder(item, args, "wave");
    let frequency_arg = ::menu::argument_finder(item, args, "freq");
    let length_arg = ::menu::argument_finder(item, args, "len");
    let channel_arg = ::menu::argument_finder(item, args, "chan");

    let waveform = match waveform_arg {
        Ok(Some("square")) | Ok(None) => Waveform::Square,
        Ok(Some("sine")) => Waveform::Sine,
        Ok(Some("sawtooth")) => Waveform::Sawtooth,
        Ok(Some("noise")) => Waveform::Noise,
        e => {
            println!("Unknown wave argument {:?}", e);
            return;
        }
    };
    let frequency = if let Ok(Some(arg)) = frequency_arg {
        match u16::from_str_radix(arg, 10) {
            Ok(f) => f,
            Err(e) => {
                println!("Bad frequency argument {:?}", e);
                return;
            }
        }
    } else {
        440
    };
    let duration = if let Ok(Some(arg)) = length_arg {
        match usize::from_str_radix(arg, 10) {
            Ok(f) => f,
            Err(e) => {
                println!("Bad duration argument {:?}", e);
                return;
            }
        }
    } else {
        60
    };
    let channel = match channel_arg {
        Ok(Some("0")) | Ok(None) => CHANNEL_0,
        Ok(Some("1")) => CHANNEL_1,
        Ok(Some("2")) => CHANNEL_2,
        e => {
            println!("Unknown duration argument {:?}", e);
            return;
        }
    };

    println!(
        "Playing...\r\nWaveform: {:?}\r\nFreq: {} Hz\r\nDuration: {} frames",
        waveform, frequency, duration
    );

    unsafe {
        crate::G_SYNTH.play(
            channel,
            Frequency::from_hertz(frequency),
            MAX_VOLUME,
            waveform,
        );
    }

    for _ in 0..duration {
        api::wfvbi();
    }

    unsafe {
        crate::G_SYNTH.play(channel, Frequency::from_hertz(frequency), 0, waveform);
    }
}

/// Init the card and dump some details
fn item_mount<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    let f = |c: &mut Context| -> Result<(), embedded_sdmmc::SdMmcError> {
        print!("Init SD card...");
        c.cont.device().init()?;
        c.cont.device().spi().reclock(10u32.mhz(), &c.clocks);
        print!("OK!\nCard size...");
        let size = c.cont.device().card_size_bytes()?;
        println!("{}", size);
        Ok(())
    };
    match f(GLOBAL_CONTEXT.lock().as_mut().unwrap()) {
        Err(e) => println!("Error: {:?}", e),
        _ => (),
    }
}

/// De-init the card so it can't be used.
fn item_unmount<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    print!("De-init SD card...");
    GLOBAL_CONTEXT
        .lock()
        .as_mut()
        .unwrap()
        .cont
        .device()
        .deinit();
    println!("OK!");
}

/// List the root directory
fn item_dir<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    let f = |c: &mut Context| -> Result<(), embedded_sdmmc::Error<_>> {
        print!("Volume 0...");
        let v = c.cont.get_volume(embedded_sdmmc::VolumeIdx(0))?;
        println!("{:?}", v);
        let dir = c.cont.open_root_dir(&v)?;
        c.cont.iterate_dir(&v, &dir, |x| {
            if !x.attributes.is_hidden() && !x.attributes.is_volume() {
                if x.attributes.is_directory() {
                    println!("{:13} {} <DIR>", x.name, x.mtime);
                } else {
                    println!("{:13} {} {} bytes", x.name, x.mtime, x.size);
                }
            }
        })?;
        c.cont.close_dir(&v, dir);
        Ok(())
    };
    match f(GLOBAL_CONTEXT.lock().as_mut().unwrap()) {
        Err(e) => println!("Error: {:?}", e),
        _ => (),
    }
}

/// Load a file from the SD card.
/// TODO work out how to release the directory handle and file handle when the
/// function aborts (e.g. with file not found).
fn item_dload<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    let f = |c: &mut Context| -> Result<(), embedded_sdmmc::Error<_>> {
        let filename = ::menu::argument_finder(item, args, "FILE")
            .unwrap()
            .unwrap();
        print!("Loading {:?}...", filename);
        let volume = c.cont.get_volume(embedded_sdmmc::VolumeIdx(0))?;
        let dir = c.cont.open_root_dir(&volume)?;
        let mut f =
            match c
                .cont
                .open_file_in_dir(&volume, &dir, filename, embedded_sdmmc::Mode::ReadOnly)
            {
                Ok(f) => f,
                Err(e) => {
                    c.cont.close_dir(&volume, dir);
                    return Err(e);
                }
            };
        let application_ram: &'static mut [u8] =
            unsafe { core::slice::from_raw_parts_mut(APPLICATION_START_ADDR, APPLICATION_LEN) };
        for b in application_ram.iter_mut() {
            *b = 0x00;
        }
        c.cont.read(&volume, &mut f, application_ram)?;
        let digest = crc::crc32::checksum_ieee(&application_ram[0..f.length() as usize]);
        println!("Loaded {} bytes, CRC32 0x{:08x}", f.length(), digest);
        c.cont.close_file(&volume, f)?;
        c.cont.close_dir(&volume, dir);
        Ok(())
    };
    match f(GLOBAL_CONTEXT.lock().as_mut().unwrap()) {
        Err(e) => println!("Error: {:?}", e),
        _ => (),
    }
}

/// Do a hex-dump of a file on disk
/// TODO work out how to release the directory handle and file handle when the
/// function aborts (e.g. with file not found).
fn item_ddump<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    let f = |c: &mut Context| -> Result<(), embedded_sdmmc::Error<_>> {
        let filename = ::menu::argument_finder(item, args, "FILE")
            .unwrap()
            .unwrap();
        print!("Dumping {:?}...", filename);
        let volume = c.cont.get_volume(embedded_sdmmc::VolumeIdx(0))?;
        let dir = c.cont.open_root_dir(&volume)?;
        let mut f =
            c.cont
                .open_file_in_dir(&volume, &dir, filename, embedded_sdmmc::Mode::ReadOnly)?;
        let application_ram: &'static mut [u8] =
            unsafe { core::slice::from_raw_parts_mut(APPLICATION_START_ADDR, APPLICATION_LEN) };
        c.cont.read(&volume, &mut f, application_ram)?;
        let digest = crc::crc32::checksum_ieee(&application_ram[0..f.length() as usize]);
        println!("Loaded {} bytes, CRC32 0x{:08x}", f.length(), digest);
        const CHUNK_SIZE: usize = 16;
        let mut lines_printed = 0;
        const MAX_LINES: usize = 35;
        for (idx, line) in application_ram[0..f.length() as usize]
            .chunks(CHUNK_SIZE)
            .enumerate()
        {
            print!("{:06x}:", idx * CHUNK_SIZE);
            for (idx, b) in line.iter().enumerate() {
                if (idx % 4) == 0 {
                    print!(" ");
                }
                print!("{:02x}", b);
            }
            println!("");
            lines_printed += 1;
            if lines_printed == MAX_LINES {
                lines_printed = 0;
                print!("Press a key...");
                loop {
                    crate::api::wfvbi();
                    // Wait for new input
                    match c.read() {
                        None => {}
                        _ => break,
                    }
                }
                print!("\r                \r");
            }
        }
        c.cont.close_file(&volume, f)?;
        c.cont.close_dir(&volume, dir);
        Ok(())
    };
    match f(GLOBAL_CONTEXT.lock().as_mut().unwrap()) {
        Err(e) => println!("Error: {:?}", e),
        _ => (),
    }
}

/// Display a text file on disk a page at a time
/// TODO work out how to release the directory handle and file handle when the
/// function aborts (e.g. with file not found).
fn item_dpage<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    let f = |c: &mut Context| -> Result<(), embedded_sdmmc::Error<_>> {
        let filename = ::menu::argument_finder(item, args, "FILE")
            .unwrap()
            .unwrap();
        println!("Displaying {:?}...", filename);
        let volume = c.cont.get_volume(embedded_sdmmc::VolumeIdx(0))?;
        let dir = c.cont.open_root_dir(&volume)?;
        let mut f =
            c.cont
                .open_file_in_dir(&volume, &dir, filename, embedded_sdmmc::Mode::ReadOnly)?;
        let application_ram: &'static mut [u8] =
            unsafe { core::slice::from_raw_parts_mut(APPLICATION_START_ADDR, APPLICATION_LEN) };
        c.cont.read(&volume, &mut f, application_ram)?;
        let mut lines_printed = 0;
        let mut line_length = 0;
        const MAX_LINES: usize = 35;
        for &b in application_ram[0..f.length() as usize].iter() {
            unsafe {
                let _ = FRAMEBUFFER.write_character(b);
            }
            line_length += 1;
            if (b == b'\n') || (line_length == 48) {
                lines_printed += 1;
                line_length = 0;
                if lines_printed == MAX_LINES {
                    lines_printed = 0;
                    print!("Press a key...");
                    loop {
                        crate::api::wfvbi();
                        // Wait for new input
                        match c.read() {
                            None => {}
                            _ => break,
                        }
                    }
                    print!("\r                \r");
                }
            }
        }
        c.cont.close_file(&volume, f)?;
        c.cont.close_dir(&volume, dir);
        Ok(())
    };
    match f(GLOBAL_CONTEXT.lock().as_mut().unwrap()) {
        Err(e) => println!("Error: {:?}", e),
        _ => (),
    }
}

fn rs232_term<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(bitrate) = ::menu::argument_finder(item, args, "bitrate")
        .unwrap_or(Some("115200"))
        .map_or(None, |p| u32::from_str_radix(p, 10).ok())
    {
        {
            let mut lock = GLOBAL_CONTEXT.lock();
            let ctx = lock.as_mut().unwrap();
            ctx.rs232_uart.change_baud_rate(bitrate.bps(), &ctx.clocks);
        }
        println!("Connected at {} bps. Ctrl-Q to quit.", bitrate);
        loop {
            let mut lock = GLOBAL_CONTEXT.lock();
            let ctx = lock.as_mut().unwrap();
            match ctx.rs232_uart.read() {
                Ok(ch) => {
                    ctx.write_u8(ch);
                }
                Err(_e) => {
                    // Ignore
                }
            }
            match ctx.read() {
                Some(Input::Cp850(17)) => {
                    // User pressed Ctrl-Q
                    break;
                }
                Some(Input::Cp850(b'\r')) => {
                    // User pressed enter
                    let _ = ctx.rs232_uart.write(b'\r');
                    let _ = ctx.rs232_uart.write(b'\n');
                }
                Some(Input::Cp850(ch)) => {
                    let _ = ctx.rs232_uart.write(ch);
                }
                Some(Input::Special(_code)) => {
                    // Drop it on the floor
                }
                None => {
                    // Do nothing
                }
            }
            cortex_m::asm::wfi();
        }
        println!("Disconnected!");
    } else {
        println!("Error: Need an integer baud rate (e.g. 115200)");
    }
}

fn midi_term<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    println!("Connected at 31,250 bps. Ctrl-Q to quit.");
    loop {
        match GLOBAL_CONTEXT.lock().as_mut().unwrap().midi_uart.read() {
            Ok(0xFE) => {
                // The 'Active Sensing' keep-alive byte
            }
            Ok(ch) => {
                print!("0x{:02x}  ", ch);
            }
            Err(_) => {
                // Do nothing
            }
        }
        match GLOBAL_CONTEXT.lock().as_mut().unwrap().read() {
            Some(Input::Cp850(17)) => {
                // User pressed Ctrl-Q
                break;
            }
            Some(Input::Cp850(ch)) => {
                let _ = GLOBAL_CONTEXT.lock().as_mut().unwrap().midi_uart.write(ch);
            }
            Some(Input::Special(_code)) => {
                // Drop it on the floor
            }
            None => {
                // Do nothing
            }
        }
        cortex_m::asm::wfi();
    }
    println!("Disconnected!");
}

fn i2c_tx<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(i2c_addr) = ::menu::argument_finder(item, args, "ADDR")
        .unwrap()
        .map_or(None, |x| parse_u32(x))
    {
        if let Some(reg_addr) = ::menu::argument_finder(item, args, "REG")
            .unwrap()
            .map_or(None, |x| parse_u32(x))
        {
            if let Some(byte) = ::menu::argument_finder(item, args, "BYTE")
                .unwrap()
                .map_or(None, |x| parse_u32(x))
            {
                let mut read_buffer = [0];
                let command = [reg_addr as u8, byte as u8];
                println!(
                    "i2c_addr={}, reg_addr={}, value={}",
                    i2c_addr, reg_addr, byte
                );
                let result = GLOBAL_CONTEXT.lock().as_mut().unwrap().i2c_bus.write_read(
                    i2c_addr as u8,
                    &command,
                    &mut read_buffer,
                );
                println!("Result={:?}, Data={:?}", result, read_buffer);
            } else {
                println!("Bad data value");
            }
        } else {
            println!("Bad register");
        }
    } else {
        println!("Bad address");
    }
}

fn i2c_rx<'a>(_menu: &Menu, item: &Item, args: &[&str], _context: &mut MenuContext) {
    if let Some(i2c_addr) = ::menu::argument_finder(item, args, "ADDR")
        .unwrap()
        .map_or(None, |x| parse_u32(x))
    {
        if let Some(reg_addr) = ::menu::argument_finder(item, args, "REG")
            .unwrap()
            .map_or(None, |x| parse_u32(x))
        {
            if let Some(count) = ::menu::argument_finder(item, args, "N")
                .unwrap()
                .map_or(None, |x| parse_u32(x))
                .map_or(None, |x| if x > 16 { None } else { Some(x) })
            {
                let mut read_buffer = &mut [0u8; 16][0..count as usize];
                let command = [reg_addr as u8];
                println!(
                    "i2c_addr={}, reg_addr={}, num={}",
                    i2c_addr as u8,
                    reg_addr as u8,
                    read_buffer.len()
                );
                let result = GLOBAL_CONTEXT.lock().as_mut().unwrap().i2c_bus.write_read(
                    i2c_addr as u8,
                    &command,
                    &mut read_buffer,
                );
                println!("Result={:?}, Data={:?}", result, read_buffer);
            } else {
                println!("Bad length");
            }
        } else {
            println!("Bad register");
        }
    } else {
        println!("Bad address");
    }
}

/// Print the entire character set
fn charset<'a>(_menu: &Menu, _item: &Item, _args: &[&str], _context: &mut MenuContext) {
    println!("Monotron Character set:");
    for row in 0..16 {
        for col in 0..16 {
            let b = row * 16 + col;
            unsafe {
                FRAMEBUFFER.write_char(b' ', None);
                FRAMEBUFFER.write_char(if (b == 10) || (b == 13) { b'.' } else { b }, None);
            }
        }
        println!();
    }
}

/// Get/set the date
fn date<'a>(_menu: &Menu, _item: &Item, args: &[&str], _context: &mut MenuContext) {
    if args.len() > 0 {
        let f = || -> Result<(), (&'static str, core::num::ParseIntError)> {
            // Set new date
            let mut iter = args[0].split(|c| " -T:/".contains(c));
            let timestamp = monotron_api::Timestamp {
                year_from_1970: (iter
                    .next()
                    .unwrap_or("1970")
                    .parse::<u32>()
                    .map_err(|e| ("Bad year", e))?
                    - 1970) as u8,
                month: iter
                    .next()
                    .unwrap_or("1")
                    .parse::<u8>()
                    .map_err(|e| ("Bad month", e))?,
                days: iter
                    .next()
                    .unwrap_or("1")
                    .parse::<u8>()
                    .map_err(|e| ("Bad days", e))?,
                hours: iter
                    .next()
                    .unwrap_or("0")
                    .parse::<u8>()
                    .map_err(|e| ("Bad hours", e))?,
                minutes: iter
                    .next()
                    .unwrap_or("0")
                    .parse::<u8>()
                    .map_err(|e| ("Bad minutes", e))?,
                seconds: iter
                    .next()
                    .unwrap_or("0")
                    .parse::<u8>()
                    .map_err(|e| ("Bad seconds", e))?,
            };
            crate::TIME_CONTEXT.set_timestamp(timestamp);
            Ok(())
        };
        println!("Setting the time - {:?}", f());
    }
    println!("Date: {}", crate::TIME_CONTEXT.get_timestamp());
}

fn parse_u32(s: &str) -> Option<u32> {
    if s.starts_with("0x") {
        // Assume hex
        u32::from_str_radix(&s[2..], 16).ok()
    } else if s.starts_with("0b") {
        // Assume binary
        u32::from_str_radix(&s[2..], 2).ok()
    } else if s.starts_with("0") {
        // Assume octal
        u32::from_str_radix(&s[1..], 8).ok()
    } else {
        // Assume decimal
        u32::from_str_radix(s, 10).ok()
    }
}

// End of file

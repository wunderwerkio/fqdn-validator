use clap::Parser;
use fqdn::FQDN;

#[derive(Parser)]
#[command(version, about)]
struct Args {
    /// Input string to check.
    input: String,

    /// If set, suppresses text output. 
    #[arg(short, long, default_value_t = false)]
    silent: bool,
}

/// Main program.
///
/// Parses the cli arguments.
/// Returns exit code 1 if invalid FQDN, 0 otherwise.
///
/// Also prints error to stderr.
fn main() -> ! {
    let cli = Args::parse();

    match cli.input.parse::<FQDN>() {
        Ok(_) => {
            std::process::exit(0);
        }
        Err(err) => {
            if !cli.silent {
                eprintln!("{err}");
            }

            std::process::exit(1);
        }
    };
}

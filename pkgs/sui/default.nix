{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "sui";
  version = "1.22.0";

  src = fetchFromGitHub {
    owner = "MystenLabs";
    repo = "sui";
    rev = "mainnet-v${version}";
    hash = "sha256-8RazuUtssjdvU545DFYjZBrGE0Ln3axtgTpEAHWGWiM=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "anemo-0.0.0" = "sha256-KZBh/i7vAF8MopWmxc403c+UkXLWv8bBrgXOy6Ro2Q4=";
      "async-task-4.3.0" = "sha256-zMTWeeW6yXikZlF94w9I93O3oyZYHGQDwyNTyHUqH8g=";
      "datatest-stable-0.1.3" = "sha256-VAdrD5qh6OfabMUlmiBNsVrUDAecwRmnElmkYzba+H0=";
      "fastcrypto-0.1.7" = "sha256-8CzB/1SqaWLhTBIHi68LDEiiGeUxyYbGetOMcJ1WeKk=";
      "json_to_table-0.6.0" = "sha256-UKMTa/9WZgM58ChkvQWs1iKWTs8qk71gG+Q/U/4D4x4=";
      "jsonrpsee-0.16.2" = "sha256-PvuoB3iepY4CLUm9C1EQ07YjFFgzhCmLL1Iix8Wwlns=";
      "msim-0.1.0" = "sha256-dqA/2xXnOdBg6O07f4gWf8XBHQqqC9W9TBpFVfM4tWU=";
      "nexlint-0.1.0" = "sha256-8UM1vRV+2mvx/4+qFgnsqzKkJgeg0mH1gX6iFYtHAAY=";
      "prometheus-parse-0.2.3" = "sha256-TGiTdewA9uMJ3C+tB+KQJICRW3dSVI0Xcf3YQMfUo6Q=";
      "real_tokio-1.36.0" = "sha256-q5jIRO3BGJVZtq3sagGFvLgL/u7dmz5yukwqFEuX3fc=";
    };
  };

  meta = {
    changelog = "";
    description = "";
    homepage = "";
    license = with lib.licenses; [];
    mainProgram = "";
    maintainers = with lib.maintainers; [];
  };
}

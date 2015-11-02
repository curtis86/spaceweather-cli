# spaceweather-cli

## A. Summary

Real-time space weather conditions, right in your shell! Useful for tracking potential Aurora conditions.
IMPORTANT: Uses spaceweather (https://github.com/curtis86/spaceweather) data to print current/near-realtime space weather data.

## B. Dependencies

Requires spaceweather (https://github.com/curtis86/spaceweather) for data retrieval.

## C. Supported Systems

This should work on any system with BASH 4 or later.

### Installation

1. Clone this repo to your preferred directory (eg: /opt/spaceweather-cli)

  `git clone https://github.com/curtis86/spaceweather-cli`

### Usage

```
Usage: spaceweather-cli <options>

Options:
  --single:  runs once and then exits.
```

### Sample Output

```
Current Kp Index: 1.67
ACE Bz: 1.7 nT
ACE Particle Density: 6.4 p/cc
ACE Solar Wind: 330.1 Km/s
Solar Wind ETA: 75 minutes.
Last Update: Mon Nov  2 08:16:49 TDT 2015

Aurora Prediction: [____________________] 4.100 % (NONE)
Next update in... 1 seconds
```

## Notes

From time to time, data measurements by ACE can include a bad or missing data record. This will be presented as *bad data* in script output.

## Disclaimer

I'm not a programmer, but I do like to make things! Please use this at your own risk.

## License

The MIT License (MIT)

Copyright (c) 2015 Curtis K

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.`

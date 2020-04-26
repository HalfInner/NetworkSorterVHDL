# Network Sorter VHDL

Network sorter implementation for FPGA. Sorts 5 numbers of 4 bit length sort in 6 tacts of CPU. Overview and usage is over UART, but can be succesfully use as sepearate module. Many serial input with a gap is possible, thus we supports continous sorting.

## N5 network overview

```
[0] o--^--------^--^-----------o
       |        |  |
[1] o--v--------|--|--^--^--^--o
                |  |  |  |  |
[2] o-----^--^--|--v--|--|--v--o
          |  |  |     |  |
[3] o--^--|--v--v-----|--v-----o
       |  |           |
[4] o--v--v-----------v--------o
```
There are 9 comparators in this network,
grouped into 6 parallel operations.
```
[[0,1],[3,4]]
[[2,4]]
[[2,3],[1,4]]
[[0,3]]
[[0,2],[1,3]]
[[1,2]]
```
This is graphed in 8 columns.


## Getting Started

### Installing

  * clone the repo
  * import into Isim tool
  * configure pins 
    * UART_TX
    * UART_RX
    * Reset
    * CLK 
  * configure FPGA / install on board
  * communicate with python script

### Example of usage
`pyserial` python library required
```python 
from serial import Serial

def printAsHex(byte_array):
    print(' '.join('{:02x}'.format(byte) for byte in byte_array))

n_values = 5
n_incorrect_values = 1
with Serial(port='/dev/ttyUSB0', baudrate=9600) as uart:
        
    test_sorted_descending = b'\x0f\x0e\x0d\x0c\x0b'
    printAsHex(test_sorted_descending)
    uart.write(test_sorted_descending)
    printAsHex(uart.read(n_values + n_incorrect_values))
    print('')
```
Usage & ouput: 
```terminal
sudo python3.7$>  ~/Programming/Utils/uart.py
0f 0e 0d 0c 0b			-- Your request
0b 0c 0d 0e 0f 00		-- FPGA answer
```

## Running the tests

Two test benches are included
 * for Network Sorter
 * for UI -- *Low quaility*

## Author

* **Kajetan Brzuszczak** - *Submitted* - [HalfInner](https://github.com/HalfInner/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
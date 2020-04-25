# NetworkSorterVHDL
Empty description FPGA. VHDL

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

[[0,1],[3,4]]
[[2,4]]
[[2,3],[1,4]]
[[0,3]]
[[0,2],[1,3]]
[[1,2]]

This is graphed in 8 columns.



## nodes of recording window on screen
ScreenBBox = (256,128,256+854,128+510)

inventory_mask = [
##"filtered out":
  [234,     445],
  [234,     510],
  [620,     510],
  [620,     428],
  [450,     428],
  [450,     445]
]

priorities = [
##"priority_main":
  [
  [619,  478],
  [619,  510],
  [854,  510],
  [854,  149],
  [532,  126],
  [396,  191],
  [320,  271],
  [320,  342],
  [363,  448]
],
##"priority_F3-1":
  [
  [27, 76],
  [67, 77],
  [67, 93],
  [27, 93]
],
##"priority_F3-2":
  [
  [660, 17],
  [760, 17],
  [760, 33],
  [660, 33]
]
]

if __name__ == "__main__":
  print(ScreenBBox)
  print(inventory_mask)
  print(priorities)
  input("\npress enter to exit")

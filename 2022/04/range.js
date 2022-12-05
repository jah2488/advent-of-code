const Range = (start, end) => {
  return {
    includes: (num) => (num >= start && num <= end),
    covers: (range) => (range.start >= start && range.end <= end),
  }
}

Range(0, 10).includes(4) // true
Range(0, 10).covers(Range(1, 9)) // true
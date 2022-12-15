def test
  puts "--- Test Data In Use ---".italic.yellow
  [1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
</code></pre>
<p><span title="The snailfish called. They want their distress signal back.">Packet data consists of lists and integers.</span> Each list starts with <code>[</code>, ends with <code>]</code>, and contains zero or more comma-separated values (either integers or other lists). Each packet is always a list and appears on its own line.</p>
<p>When comparing two values, the first value is called <em>left</em> and the second value is called <em>right</em>. Then:</p>
<ul>
<li>If <em>both values are integers</em>, the <em>lower integer</em> should come first. If the left integer is lower than the right integer, the inputs are in the right order. If the left integer is higher than the right integer, the inputs are not in the right order. Otherwise, the inputs are the same integer; continue checking the next part of the input.</li>
<li>If <em>both values are lists</em>, compare the first value of each list, then the second value, and so on. If the left list runs out of items first, the inputs are in the right order. If the right list runs out of items first, the inputs are not in the right order. If the lists are the same length and no comparison makes a decision about the order, continue checking the next part of the input.</li>
<li>If <em>exactly one value is an integer</em>, convert the integer to a list which contains that integer as its only value, then retry the comparison. For example, if comparing <code>[0,0,0]</code> and <code>2</code>, convert the right value to <code>[2]</code> (a list containing <code>2</code>); the result is then found by instead comparing <code>[0,0,0]</code> and <code>[2]</code>.</li>
</ul>
<p>Using these rules, you can determine which of the pairs in the example are in the right order:</p>
<pre><code>== Pair 1 ==
- Compare [1,1,3,1,1] vs [1,1,5,1,1]
  - Compare 1 vs 1
  - Compare 1 vs 1
  - Compare 3 vs 5
    - Left side is smaller, so inputs are <em>in the right order</em>

== Pair 2 ==
- Compare [[1],[2,3,4]] vs [[1],4]
  - Compare [1] vs [1]
    - Compare 1 vs 1
  - Compare [2,3,4] vs 4
    - Mixed types; convert right to [4] and retry comparison
    - Compare [2,3,4] vs [4]
      - Compare 2 vs 4
        - Left side is smaller, so inputs are <em>in the right order</em>

== Pair 3 ==
- Compare [9] vs [[8,7,6]]
  - Compare 9 vs [8,7,6]
    - Mixed types; convert left to [9] and retry comparison
    - Compare [9] vs [8,7,6]
      - Compare 9 vs 8
        - Right side is smaller, so inputs are <em>not</em> in the right order

== Pair 4 ==
- Compare [[4,4],4,4] vs [[4,4],4,4,4]
  - Compare [4,4] vs [4,4]
    - Compare 4 vs 4
    - Compare 4 vs 4
  - Compare 4 vs 4
  - Compare 4 vs 4
  - Left side ran out of items, so inputs are <em>in the right order</em>

== Pair 5 ==
- Compare [7,7,7,7] vs [7,7,7]
  - Compare 7 vs 7
  - Compare 7 vs 7
  - Compare 7 vs 7
  - Right side ran out of items, so inputs are <em>not</em> in the right order

== Pair 6 ==
- Compare [] vs [3]
  - Left side ran out of items, so inputs are <em>in the right order</em>

== Pair 7 ==
- Compare [[[]]] vs [[]]
  - Compare [[]] vs []
    - Right side ran out of items, so inputs are <em>not</em> in the right order

== Pair 8 ==
- Compare [1,[2,[3,[4,[5,6,7]]]],8,9] vs [1,[2,[3,[4,[5,6,0]]]],8,9]
  - Compare 1 vs 1
  - Compare [2,[3,[4,[5,6,7]]]] vs [2,[3,[4,[5,6,0]]]]
    - Compare 2 vs 2
    - Compare [3,[4,[5,6,7]]] vs [3,[4,[5,6,0]]]
      - Compare 3 vs 3
      - Compare [4,[5,6,7]] vs [4,[5,6,0]]
        - Compare 4 vs 4
        - Compare [5,6,7] vs [5,6,0]
          - Compare 5 vs 5
          - Compare 6 vs 6
          - Compare 7 vs 0
            - Right side is smaller, so inputs are <em>not</em> in the right order
.split("\n")
end

puzzle '13.1', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end

xpuzzle '13.2', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end

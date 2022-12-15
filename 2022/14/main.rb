def test
  puts "--- Test Data In Use ---".italic.yellow
  498,4 -&gt; 498,6 -&gt; 496,6
503,4 -&gt; 502,4 -&gt; 502,9 -&gt; 494,9
</code></pre>
<p>This scan means that there are two paths of rock; the first path consists of two straight lines, and the second path consists of three straight lines. (Specifically, the first path consists of a line of rock from <code>498,4</code> through <code>498,6</code> and another line of rock from <code>498,6</code> through <code>496,6</code>.)</p>
<p>The sand is pouring into the cave from point <code>500,0</code>.</p>
<p>Drawing rock as <code>#</code>, air as <code>.</code>, and the source of the sand as <code>+</code>, this becomes:</p>
<pre><code>
  4     5  5
  9     0  0
  4     0  3
0 ......+...
1 ..........
2 ..........
3 ..........
4 ....#...##
5 ....#...#.
6 ..###...#.
7 ........#.
8 ........#.
9 #########.
</code></pre>
<p>Sand is produced <em>one unit at a time</em>, and the next unit of sand is not produced until the previous unit of sand <em>comes to rest</em>. A unit of sand is large enough to fill one tile of air in your scan.</p>
<p>A unit of sand always falls <em>down one step</em> if possible. If the tile immediately below is blocked (by rock or sand), the unit of sand attempts to instead move diagonally <em>one step down and to the left</em>. If that tile is blocked, the unit of sand attempts to instead move diagonally <em>one step down and to the right</em>. Sand keeps moving as long as it is able to do so, at each step trying to move down, then down-left, then down-right. If all three possible destinations are blocked, the unit of sand <em>comes to rest</em> and no longer moves, at which point the next unit of sand is created back at the source.</p>
<p>So, drawing sand that has come to rest as <code>o</code>, the first unit of sand simply falls straight down and then stops:</p>
<pre><code>......+...
..........
..........
..........
....#...##
....#...#.
..###...#.
........#.
......<em>o</em>.#.
#########.
</code></pre>
<p>The second unit of sand then falls straight down, lands on the first one, and then comes to rest to its left:</p>
<pre><code>......+...
..........
..........
..........
....#...##
....#...#.
..###...#.
........#.
.....oo.#.
#########.
</code></pre>
<p>After a total of five units of sand have come to rest, they form this pattern:</p>
<pre><code>......+...
..........
..........
..........
....#...##
....#...#.
..###...#.
......o.#.
....oooo#.
#########.
</code></pre>
<p>After a total of 22 units of sand:</p>
<pre><code>......+...
..........
......o...
.....ooo..
....#ooo##
....#ooo#.
..###ooo#.
....oooo#.
...ooooo#.
#########.
</code></pre>
<p>Finally, only two more units of sand can possibly come to rest:</p>
<pre><code>......+...
..........
......o...
.....ooo..
....#ooo##
...<em>o</em>#ooo#.
..###ooo#.
....oooo#.
.<em>o</em>.ooooo#.
#########.
</code></pre>
<p>Once all <code><em>24</em></code> units of sand shown above have come to rest, all further sand flows out the bottom, falling into the endless void. Just for fun, the path any new sand takes before falling forever is shown here with <code>~</code>:</p>
<pre><code>.......+...
.......~...
......~o...
.....~ooo..
....~#ooo##
...~o#ooo#.
..~###ooo#.
..~..oooo#.
.~o.ooooo#.
~#########.
~..........
~..........
~..........
.split("\n")
end

puzzle '14.1', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end

xpuzzle '14.2', mode: :count, answer: nil do |input, total|
  test.each do |line|

  end
end

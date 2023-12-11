/* REXX */

x = bpxwunix('cat /z/zuserid/aoc2023/day5solutioninput.txt' ,,file.,se.)

NUMERIC DIGITS 11

/* first get our seeds */
seeds. = ''
lowest_seed_location = -1

parse var file.1 "seeds:" seedlist
do seedidx = 1 to words(seedlist)
  seeds.seedidx = strip(word(seedlist,seedidx))
end
seeds.0 = words(seedlist)

/* then parse the transformations */
formulas. = ''
formulas.0 = 0
fidx = 0

do i = 2 to file.0
  if file.i = '' then do
    /* blank line, next forumla is up... */
    fidx = fidx + 1
    formulas.0 = formulas.0 + 1
    i = i + 1 /* skip over x-to-y map: line */
  end
  else do
    /* formula information for this fidx */
    formulas.fidx = formulas.fidx translate(file.i,',',' ')
  end
end

/* Let's see what we've got */
do i = 1 to formulas.0
  say formulas.i
end

/* loop our seeds, loop transformation formulas, store location */
do i = 1 to seeds.0
  location = seeds.i
  /*
  say "Seed" seeds.i "being calculated"
  */
  do j = 1 to formulas.0
    /*
    say "  formulas" j "->" formulas.j
    */
    do k = 1 to words(formulas.j)
      fdata = word(formulas.j,k)
      parse var fdata dval","sval","rval
      newloc = x2y(location,dval,sval,rval)
      if newloc <> location then do
        location = newloc
        /*
        say "    brings it to" location
        */
        location = newloc
        leave /* no more formulas to process */
      end
    end
  end
  say "seed" i "goes to" location

  if lowest_seed_location = -1 | location < lowest_seed_location then
    lowest_seed_location = location

end

say "Part 1: Lowest Seed Location:" lowest_seed_location


exit

x2y: procedure
  parse arg x,d,s,r
  /* We get a value, dest, start and range
     s maps to d
     s+1 maps to d+1
     up to s+r maps to d+r
  */
  if x >= s & x <= s + r then do
    /* our input is in source range */
    offset = x - s
    return d + offset
  end
  else do
    /* input is out of range */
    return x
  end
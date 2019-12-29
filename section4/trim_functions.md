## `ALLTRIM()`, `LTRIM()`, `RTRIM()`, `TRIM()`

The functions in this group are used for removing spaces from the beginning or end of character strings. 
Let's clear up one thing right away: `RTRIM()` and `TRIM()` are identical. 
So, to paraphrase George Carlin, why are there two? Yep, it's another Xbase history thing. 
Way back when, the only function in this group was `TRIM()`, which removes trailing blanks from a string. 
Then `LTRIM()` was added to remove leading blanks. 
We figured the "L" stood for "Leading," but somehow people started thinking of it as "Left TRIM." 
Well, if there's a "Left TRIM," there must be a "Right TRIM," so `RTRIM()` was added to be complementary to `LTRIM()`. 
Another case of useless dBloat.

Technically, `ALLTRIM()`, which removes leading and trailing blanks, isn't really necessary either. 
You can do the same thing with `LTRIM(TRIM(<a string>))`. 
Even with a million or so iterations, the `ALLTRIM()` version is only slightly faster than the nested call, 
so it's not speed. We suppose it is a little easier to code it with `ALLTRIM()`.

### Usage

```foxpro
cReturnValue = ALLTRIM(cString)
cReturnValue = LTRIM(cString)
cReturnValue = RTRIM(cString)
cReturnValue = TRIM(cString)
```

The trim functions are particularly useful in two places. 
First is when dealing with character fields that may not be full, especially if you want to measure their length. 
`LEN(<a field>)` gives you the defined length of the field, not the amount of data it actually contains. 
To get that, you need:

```foxpro
LEN(TRIM(<a field>))
```
or, if there may be leading blanks:

```foxpro
LEN(ALLTRIM(<a field>))
```
The second place where trimming is particularly handy is in dealing with user input. 
If you want to search based on an input string, it's best to trim leading and trailing blanks. 
Users have a tendency to not worry about cursor position when they start typing, 
or whether they've added extra spaces at the end. 
Say you're looking for a particular company in TasTrade's Customer table. 
If the name entered by the user is in `m.cCompany`, it's best to:

```foxpro
SET ORDER TO Company_Na
SEEK UPPER(ALLTRIM(m.cCompany))
```
Finally, notice that even `ALLTRIM()` doesn't remove all blanks from a string, just those at the beginning and end. 
Embedded blanks aren't touched&mdash;take a look at `STUFF()`, `STRTRAN()` and `CHRTRAN()` for that sort of thing.

### Example

```foxpro
* If cFirstName and cLastName are fields,
* return a person's full name in the usual format
* For example: Herman Munster
?ALLTRIM(cFirstName)+" "+ALLTRIM(cLastName)
```

### See Also

[`ChrTran()`](s4g006.md), [`Len()`](s4g016.md), [`PadC()`](s4g019.md), [`PadL()`](s4g019.md), [`PadR()`](s4g019.md), [`StrTran()`](s4g006.md), [`Stuff()`](s4g006.md)

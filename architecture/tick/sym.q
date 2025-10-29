/define an unkeyeed table with typed columns
/sym is given g attribute -- grouped attribute, for performance enhancement
trade:([]time:`timespan$();sym:`g#`symbol$();price:`float$();side:`symbol$());
/lets define a quotes table
quote:([]time:`timespan$();sym:`g#`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$());
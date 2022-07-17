#!/bin/bash
#alae bohoudi
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."
else
  # if a number 
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
     # get element with atomic number 
    ELEMENT_INFOS=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) WHERE elements.atomic_number=$1" )
   #if argument symbol 
  elif [[ $1 =~ ^[a-Z]{1,2}$ ]]   
  then 
    ELEMENT_INFOS=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) WHERE elements.symbol='$1' ")
   #if argument a name
  else
    ELEMENT_INFOS=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) WHERE elements.name='$1'")
  fi
  #if no results found
  if [[ -z $ELEMENT_INFOS ]]
  then
  echo -e "I could not find that element in the database."
  else
  echo "$ELEMENT_INFOS" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
       do
        TYPES=$($PSQL "SELECT type FROM types WHERE type_id= $TYPE_ID")
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a$TYPES, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done 

  
  fi

 

fi

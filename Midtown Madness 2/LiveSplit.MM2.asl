// version 3.0.1

state("midtown2") {
    //int loading_value : 0x1E0CCC;
    int loading_value : 0x2B17C8;
    int race_state : 0x1B65AC, 0x518;
    //string256 message_on_screen : 0x22751C, 0xC, 0x20, 0x4, 0x30, 0x10;
}

/* race_state values description:
    0: First state when you start a race.
    1: First message on screen ("Ready" for all races, it varies for crash courses).
    2: Second message on screen ("Set" for all races, it varies for crash courses).
    3: "Go!" message appear and you can move the car.
    4: "Game over" for every race type. "Time's up" in blitz races have this value.
    5: Victory screen for all races. For checkpoint and circuit races you still have this
        value when not finishing 1st.
    6: Victory screen for all crash courses.
    
    When loading I observed some other values saved in this variable:
    353784856   '00010101000101100101010000011000'
    554262305   '00100001000010010101111100100001'
    1090524225  '01000001000000000001010001000001' : Very common
    3267088057  '11000010101110111100111010111001'
*/

/* loading_value values description:
    -1: The game is not loading.
     0: The game is loading the main menu.
     1: The game is loading a level.
*/


startup {
    //bool split_done = false;
    bool must_split = false;
}

init {
    vars.must_split = false;
}

start { // Start the timer
    return current.loading_value == 1;
}

isLoading {
    //return current.loading_value != 0;
    //return current.loading_value != 0xFFFFFFFF;
    return current.loading_value != -1;
}

update {
    if((current.race_state == 5 || current.race_state == 6) && old.race_state == 3){
        vars.must_split = true;
    }
    else{
        vars.must_split = false;
    }
}

split {
    return vars.must_split;
}

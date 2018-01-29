module Map

class Room
    def initialize(name, description)
        @name = name
        @description = description
        @paths = {}
    end
    
    attr_reader :name
    attr_reader :paths
    attr_reader :description

    def go(direction)
        return @paths[direction]
    end
    
    def add_paths(paths)
        @paths.update(paths)
    end
end

    Introduction = Room.new("Introduction",
    """
    Welcome to the Great Kingdoms of Westeros.
    You are playing as Cersei Lannister, current queen of the Seven Kingdoms.
    Your goal is to bring order to the Seven Kingdoms by conquering as much land as possible.
    Please make sure that any and all commands you enter a fully lowercase.
    Enter 'ready' to continue and good luck!
    """)


    CerseiPlan = Room.new("Plan Your Move",
    """
    Welcome to King's Landing Cersei.
    As ruler of Westeros you have a lot to do!
    Looks like things aren't going too well right now...
    Jon Snow is rallying men in the North.
    Daenerys Targaryen is crossing the Narrow Sea with her army and dragons.
    And The Night King and his dead are approaching the Wall.
    Who will you focus on first? Jon, Dany or The Night King?
    """)


    CerseivsJon = Room.new("Cersei vs Jon",
    """
    You have two choices:
    You can directly attack Jon or wait to see his strategy.
    Type 'attack' to attack, or 'wait' to wait.
    """)
    
    
    JonWait = Room.new("Wait",
    """
    Good choice!
    Your little birds bring you daily reports on Jon's doings.
    It turns out he is having some trouble keeping all of the houses united.
    You send messengers to each house, promising them riches and freedom.
    House Umber and House Karstark join your cause.
    You convince them to send a solider to murder Jon Snow in the night.
    The following morning the Northerners find Jon Snow's head on a pike, along with a note.
    The note demands the remaining rebels join Cersei or die.
    One by one, the houses give in and pledge their loyalty.
    Type 'continue' to keep going.
    """)


    CerseiPlan2 = Room.new("Plan Your Next Move",
    """
    After a first victory, you are back at The Red Keep.
    With Jon Snow dead, Daenerys Targaryen and The Night King are the only ones left.
    Who will you battle next? Dany or The Night King?
    """)


    CerseivsDany = Room.new("Cersei vs Dany",
    """
    There are two ways you can go about attacking Dany.
    You can lay siege to Dragonstone or attack the castle from the sea.
    What will it be? Siege or attack?
    """)


    CerseivsNightKing = Room.new("Cersei vs Night King",
    """
    You assemble your northern troops for battle.
    There are two ways you can go about this:
    You can march through the gates in the wall, or plan a defensive setup.
    So, what will it be? Attack or defend?
    """)


    CerseiPlan3 = Room.new("Plan Your Next Move",
    """
    The only enemty left now is Dany and her allies.
    Together, they have managed to land at Dragonstone.
    Type 'continue' to keep going.
    """)
    
    
    End = Room.new("The End",
    """
    This is the end for you.
    You did the best you could!
    Congratulations on your adventure conqueror!
    Feel free to restart the game, or close the window if you're done playing.
    """)
    
    
    Introduction.add_paths({
        'ready' => CerseiPlan,
    })


    CerseiPlan.add_paths({
        'jon' => CerseivsJon,
        'dany' => CerseivsDany,
        'the night king' => CerseivsNightKing
    })
    

    CerseivsJon.add_paths({
        'attack' => End,
        'wait' => JonWait
    })


    JonWait.add_paths({
        'continue' => CerseiPlan2,
    })
    
    
    CerseiPlan2.add_paths({
        'dany' => CerseivsDany,
        'the night king' => CerseivsNightKing
    })
    
    
    CerseivsDany.add_paths({
        'siege' => End,
        'attack' => End
    })
    
    
     CerseivsNightKing.add_paths({
        'attack' => End,
        'defend' => CerseiPlan3
    })
    
    
     CerseiPlan3.add_paths({
        'continue' => CerseivsDany,
    })
    

    START = Introduction
    
    
    ROOM_NAMES = {
        'Introduction' => Introduction,
        'CerseiPlan' => CerseiPlan,
        'CerseivsJon' => CerseivsJon,
        'JonWait' => JonWait,
        'CerseiPlan2' => CerseiPlan2,
        'CerseivsDany' => CerseivsDany,
        'CerseivsNightKing' => CerseivsNightKing,
        'CerseiPlan3' => CerseiPlan3,
        'End' => End
    }

    def Map::load_room(session)
        return ROOM_NAMES[session[:room]]
    end

    def Map::save_room(session, room)
        session[:room] = ROOM_NAMES.key(room)
    end
end
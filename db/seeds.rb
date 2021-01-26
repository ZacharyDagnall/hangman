
Game.destroy_all
Player.destroy_all
Word.destroy_all
GameWord.destroy_all
Hint.destroy_all

Player.reset_pk_sequence
Word.reset_pk_sequence
GameWord.reset_pk_sequence
Hint.reset_pk_sequence
Game.reset_pk_sequence

#	pick easy word
Word.create(the_word: "spot",point_value: 1);
Word.create(the_word:"area",point_value: 1);
Word.create(the_word:"cat",point_value: 1);
Word.create(the_word:"park",point_value: 1);
Word.create(the_word:"green",point_value: 1);
Word.create(the_word:"hey",point_value: 1);
Word.create(the_word:"easy",point_value: 1);
Word.create(the_word:"yes",point_value: 1);
Word.create(the_word:"red",point_value: 1);
Word.create(the_word:"ball",point_value: 1);
# pick medium word
Word.create(the_word:"kayak",point_value: 2);
Word.create(the_word:"guitar",point_value: 2);
Word.create(the_word:"atomic",point_value: 2);
Word.create(the_word:"brittle",point_value: 2);
Word.create(the_word:"airplane",point_value: 2);
Word.create(the_word:"scratch",point_value: 2);
Word.create(the_word:"fox",point_value: 2);
Word.create(the_word:"violet",point_value: 2);
Word.create(the_word:"sushi",point_value: 2);
Word.create(the_word:"joke",point_value: 2);
Word.create(the_word:"strong",point_value: 2);
Word.create(the_word:"apple",point_value: 2);
Word.create(the_word:"orange",point_value: 2);
Word.create(the_word:"steak",point_value: 2);
Word.create(the_word:"sauce",point_value: 2);
# pick expert word
Word.create(the_word:"banana",point_value: 3);
Word.create(the_word:"elephant",point_value: 3);
Word.create(the_word:"zipper",point_value: 3);
Word.create(the_word:"quiz",point_value: 3);
Word.create(the_word:"rhythm",point_value: 3);
Word.create(the_word:"ivy",point_value: 3);
Word.create(the_word:"crocodile",point_value: 3);
Word.create(the_word:"xenophobia",point_value: 3);
Word.create(the_word:"abrupt",point_value: 3);
Word.create(the_word:"impeachment",point_value: 3);
Word.create(the_word:"absurd",point_value: 3);
Word.create(the_word:"blizzard",point_value: 3);
Word.create(the_word:"jazz",point_value: 3);
Word.create(the_word:"jinx",point_value: 3);
Word.create(the_word:"juicy",point_value: 3);
Word.create(the_word:"galaxy",point_value: 3);
Word.create(the_word:"pixel",point_value: 3);
Word.create(the_word:"gnarly",point_value: 3);
Word.create(the_word:"puzzle",point_value: 3);
Word.create(the_word:"stymied",point_value: 3);
Word.create(the_word:"strength",point_value: 3);
Word.create(the_word:"luxury",point_value: 3);
Word.create(the_word:"revolt",point_value: 3);
Word.create(the_word:"sideways",point_value: 3);
Word.create(the_word:"element",point_value: 3);

sam = Player.create(username: "Sam")
zak = Player.create(username: "Zak")

first_game = Game.create(player: sam)
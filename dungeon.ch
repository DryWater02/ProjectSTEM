#include <chplot.h>
double x, y, bx = 1.5, by = 1.5;
int p = 1;
int turns, num, chance;
string_t ready = "no";
string_t location, move, foe, e;
string_t maps[5] = {"woods", "desert", "jungle", "sky", "sea"};
int start =1, movement = 0;
string_t weapon, naming;
int PAtk=10,PDef=6,PHP=30, PTec=3, PKi=3, PAgi=7, PDod, PMaxDef,PLuk=5,Crit, minions, slime=0;
int PHPMax, PAtkMax, PLukMax, PAgiMax, DualBlades, CritCount, PoisonDur;
double EHP, EMHP, EDef, EAtkMax,EAtkMin,EAtk, Dmg;
string_t TechCh, Wave, Dodged="False",DodgedAction="False", Critical="False", Allah="False", Dead="False", ZandatsuTrig="False", claws = "False", EDodged = "False";
int PT, APL, SS, Clover, HB, IF, Tech, Drop, DefStacks, UnlimitedCritWorks, charge;
string_t Action, TrueAction = "False",  Technique="False";
int attack;

string_t sus;
int DefDamageCalc, PDefDamageCalc;
int VAtkT;
int Phase = 1;
int DualLvl = 0, katanaLvl = 0;
int VNuke;
int TaisuT, EDodge, EAgi = 7, EAgiMax;
string_t UIDodge="False";
int EPT;
string_t katana="False",Spirit="False",Sheathed="False",CounterStance="False",CounterSpiritStance="False";

PMaxDef=PDef;
PHPMax=PHP;
PAtkMax=PAtk;
string_t name;
struct enemy{
    string_t name;
        double Atk;
        double Def;
        double HP;
    };
struct boss{
    string_t name;
        double Atk;
        double Def;
        double HP;
    };
/*Woods*/
struct enemy bug = {"Beetle", 2, 2, 3};
struct enemy gup = {"Gup", 5, 3, 8};
    struct enemy geep = {"Geep", 4, 3, 5};
        struct enemy gip = {"Gip", 1, 1, 1};
struct enemy rock = {"Stone Golem", 6, 5, 5};

struct boss vagrant = {"Wandering Vagrant", 9, 20, 100};
struct boss bigBug = {"Queen Beetle", 20, 17, 25};
struct boss gorp = {"Gorp", 10, 10, 30};

string_t woodsFoe[3] = {"bug", "gup", "rock"};
string_t woodsBoss[3] = {"vagrant", "bigBug", "gorp"};
        
/*Jungle*/
struct enemy bees = {"Swarm of Bees", 1, 1, 1};
struct enemy blood = {"Mosquito", 1, 1, 1};
struct enemy monke = {"Monkey", 6, 2, 8};

struct boss bigBee = {"Queen Bee", 8, 16, 13};
struct boss gorilla = {"Gorilla", 18, 2, 12};
struct boss death = {"Deathbloom", 12, 0, 60};

string_t jungleFoe[3] = {"bees", "blood", "monke"};
string_t jungleBoss[3] = {"bigBee", "gorilla", "death"};

/*Desert*/
struct enemy scorpion = {"Scorpion", 4, 3, 9};
struct enemy cactus = {"Cactus", 0, 6, 7};
struct enemy sandShark = {"Sand shark", 7, 2, 5};

struct boss worm = {"Sand worm", 8, 1, 22};
struct boss sphinx = {"Sphinx", 7, 11, 14};
struct boss sun = {"Sun", 20, 0, 40};

string_t desertFoe[3] = {"scorpion", "cactus", "sandShark"};
string_t desertBoss[3] = {"worm", "sphinx", "sun"};

/*sea*/
struct enemy puffer = {"Puffer fish", 1, 4, 8};
struct enemy shark = {"Shark", 9, 2, 5};
struct enemy lobster = {"Lobster", 4, 5, 9};

struct boss bahamut = {"Bahamut", 21, 6, 19};
struct boss serpent = {"Leviathan", 13, 13, 13};
struct boss hydra = {"Hydra", 9, 11, 35};

string_t seaFoe[3] = {"puffer", "shark", "lobster"};
string_t seaBoss[3] = {"bahamut", "serpent", "hydra"};

/*Sky*/
struct enemy harpy = {"Harpy", 5, 1, 5};
struct enemy birds = {"Stymphalian birds", 6, 3, 3};
struct enemy wyvern = {"Wyvern", 10, 2, 6};

struct boss wyrm = {"Wyrm", 14, 14, 10};
struct boss eagle = {"Hraesvelg", 13, 6, 17};
struct boss sky = {"Ouranos", 11, 0, 60};


string_t skyFoe[3] = {"harpy", "birds", "wyvern"};
string_t skyBoss[3] = {"wyrm", "eagle", "sky"};

void fight(struct enemy s);
double xcord(string_t move, double x);
double ycord(string_t move, double y);
void Map(string_t location, double bx, double by);
string_t teleporter(string_t location, int turns);
void winEnd (struct boss s, int turns, string_t name, string_t weapon);
int playerturns();
int hit();
void lose ();

int killed(){
    turns=turns+1;
    PAtk=PAtkMax;
    if (ZandatsuTrig=="True"){
        Drop=randint(1,5);
        if (Drop==1){
            PHP=PHP+4;
            printf("The Zandatsu helped you gain life essence from the enemy's body.\n");
            sleep(p);
        }
    }
    PHP=PHP+2;
    if (PHP>PHPMax){
        PHP=PHPMax;
    }
    Drop=randint(1,5);
    if (Drop==1){
        Drop=randint(1,16);
        if (Drop==1&&ZandatsuTrig!="True"){
            ZandatsuTrig="True";
            printf("You got the Zandatsu!\n");
            sleep(p);
        }
        else if (Drop==2&&ZandatsuTrig!="True"){
            ZandatsuTrig="True";
            printf("You got the Zandatsu!\n");
            sleep(p);
        }
        else{
            Drop=randint(3,15);
        }
        if (Drop==3||Drop==4){
            PT=PT+1;
            printf("You got a Poison Tip item! You have ",PT," Poison Tip items.\n");
            sleep(p);
        }
        else if (Drop==5||Drop==6){
            APL=APL+1;
            printf("You got a Armor Plate item! You have ",APL," Armor Plate items.\n");
            sleep(p);
            PDef=PDef+3;
            PMaxDef=PDef;
        }
        else if (Drop==7||Drop==8){
            Clover=Clover+1;
            printf("You got a Clover item! You have ",Clover," Clover items.\n");
            sleep(p);
            PLuk=PLuk+1;
            PLukMax=PLuk;
            }
        else if (Drop==9||Drop==10){
            SS=SS+1;
            printf("You got a Sharpening Stone item! You have ",SS," Sharpening Stone items.\n");
            sleep(p);
            PAtk=PAtk+2;
            PAtkMax=PAtk;
        }
        else if (Drop==11||Drop==12){
            HB=HB+1;
            printf("You got a Hermes Boots item! You have ",HB," Hermes Boots items.\n");
            sleep(p);
            PAgi=PAgi+2;
            PAgiMax=PAgi;
        }
        else if (Drop==13||Drop==14){
            IF=IF+1;
            printf("You got a Infusion item! You have ",IF," Infusion items.\n");
            sleep(p);
            PHP=PHP+2;
            PHPMax=PHP;
        }
        else if (Drop==15){
            UnlimitedCritWorks=UnlimitedCritWorks+1;
            printf("You got Unlimited Crit Works! You have ",UnlimitedCritWorks," of them.\n");
            sleep(p);
        }
        else if (Drop==16&&katanaLvl>=1){
            katanaLvl=katanaLvl+1;
            printf("You have honed your skill with the blade, you now have the ");
            if (katanaLvl==2){
                printf("Yamato technique, meaning you can now use specials without the need for the Sheath.\n");
                sleep(p);
            }
            else if (katanaLvl==3){
                printf("Rodrigues Shadow Technique, Sheathed attacks permantly increase damage, and Spirit buff is always true.\n");
                sleep(p);
            }
        }
        else if (Drop==16&&DualLvl>=1){
            DualLvl=DualLvl+1;
            printf("You have honed your skill, you now have ");
            if (DualLvl==2){
                printf("the Taisu Technique\n","You can now attack 2 more times.\n");
                sleep(p);
            }
            else if (DualLvl==3){
                printf("Mastered Dual Blades\n","Giving your dodge a 80% chance to dodge, an extra attack, and better damage per hit.\n");
                sleep(p);
            }
        }
    }
    return PAtk, PAtkMax, turns, PDef;
}



printf ("What is your character's name?\n");
scanf("%s", &name);
printf("Welcome, %s.\n", name);
sleep(p);


srand(time(0));

num = (rand() % (4 - 0 + 1)) + 0;
location = maps[num];
if (maps[num] == "woods"){
    printf ("You find yourself in a land of green,\n");
    sleep (1);
    printf("surronded by large trees and tall grass.\n");
    sleep (1);
    printf ("Your ears fill with noise, and you are completely surrounded.\n");
    sleep (1);
    printf ("You see movement within the tall grass, and notice a beetle in there,\n");
    sleep (1);
    printf ("but there is a difference from the beetles you know.\n");
    sleep (1);
    printf ("It is incredibly large, equal to you in size, and it hasn't noticed you yet.\n");
    sleep (1);
    printf ("Though the thick grass is tough to see through,\n");
    sleep (1);
    printf ("you can make out a strange structure in the distance, maybe it will be your way out.\n");
    sleep (1);
}
if (maps[num] == "jungle"){
    printf ("You wake up to the sounds of running water,\n");
    sleep (1);
    printf("and are surrounded by exotic plants and biting mosquitoes.\n");
    sleep (1);
    printf ("You feel the moisture in the air, and your ears fill with noise.\n");
    sleep (1);
    printf ("In the distance, you see a rather large beehive.\n");
    sleep (1);
    printf ("The workers within pouring out like water.\n");
    sleep (1);
    printf ("The muddy earth beneath you is hard to walk across,\n");
    sleep (1);
    printf ("but at least you can see a strange structure in the distance,\n");
    sleep (1);
    printf ("maybe that will be your way out.\n");
    sleep (1);
}
if (maps[num] == "desert"){
    printf("You wake up to a bleak orange field,\n");
    sleep (1);
    printf("and you find that you are surrounded by nothing but sand.\n");
    sleep (1);
    printf("Arid winds blow across your face as the blistering sun shines down on you.\n");
    sleep (1);
    printf("You think one of the cacti shifted, but you simply blame the desert heat.\n");
    sleep (1);
    printf("A large structure in the distance seems like a good spot for shade.\n");
    sleep (1);
}
if (maps[num] == "sea"){
    printf("You wake up to a dark abyss,\n");
    sleep (1);
    printf ("you are surronded by coral and fish,\n");
    sleep (1);
    printf("you can already tell you are underwater.\n");
    sleep (1);
    printf("Despite the water, it seems you can still breathe,\n");
    sleep (1);
    printf("but can feel the touch of the water around you.\n");
    sleep (1);
    printf("A small fish swims by, but it inflates into a ball of spikes once you try to get near. \n");
    sleep (1);
    printf("Though it is hard to make out, you can just barely see a strange stucture off in the distance.\n");
    sleep (1);
    }
if (maps[num] == "sky"){
    printf("You wake up to a snow white floor and a bright blue sky. \n");
    sleep (1);
    printf("You appear to be high up in the sky and standing on a cloud. \n");
    sleep (1);
    printf("A cold breeze blows past your face, chilling you instantly. \n");
    sleep (1);
    printf("Somehow, there is a building off in the distance,\n");
    sleep (1);
    printf("strange structure that is also placed upon the clouds.\n");
    sleep (1);
    }
    

while (start == 1){
    printf ("\nYou see a weapon in front of you, what is it? (sword, katana, or dual daggers)\n");
    scanf ("%s", &Technique);
    if (Technique == "katana" || Technique == "Katana"){
        Technique = "katana";
        weapon = "your katana";
        start = 0;
    }
    else if (Technique == "dual daggers" || Technique == "Dual Daggers" || Technique == "Dual daggers"){
        Technique = "dual";
        weapon = "your dual daggers";
        start = 0;
    }
    else if (Technique == "sword" || Technique == "sword"){
        Technique = "sword";
        weapon = "your sword";
        start = 0;
    }
    
    else {
        printf("please input a valid response\n");
    }
}
start = 1;
while (start == 1){
    printf ("Would you like to name your weapon?\n");
    scanf ("%s", &naming);
    if (naming == "yes" || naming == "Yes"){
        printf("What is the name of your weapon?\n");
        scanf("%s", &weapon);
        start = 0;
    }
    else if (naming == "no" || naming == "No"){
        start = 0;
    }
    else {
        printf("please input a valid response\n");
    }
}
        
int main(){
    Map(location, bx, by);
    while(1){
        while (movement == 0){
            printf("\nWhich way do you want to go?\n");
            scanf("%s", &move);
            if (move == "PowerOfAllahMurasama" && Allah != "True"){
                PAtk=PAtk*999;
                PAtkMax=PAtk;
                Allah="True";
            }
            if (move == "up" || move == "down" || move == "north" || move == "south"){
                by = by + ycord(move, y);
                if (by > 6){
                printf("That is out of bounds.\n");
                sleep (1);
                turns = turns - 1;
                by = by - ycord(move, y);
                }
            else if (by < 1){
                printf("That is out of bounds.\n");
                sleep (1);
                turns = turns - 1;
                by = by - ycord(move, y);
                }
                printf ("%.1lf, %.1lf\n", bx, by);
                sleep (1);
                Map(location, bx, by);
                turns = turns + 1;
                movement = 1;
            }
            else if (move == "left" || move == "right" || move == "east" || move == "west"){
                bx = bx + xcord(move, x);
                if (bx > 6){
                printf("That is out of bounds.\n");
                sleep (1);
                bx = bx - xcord(move, x);
                turns = turns - 1;
            }
            else if (bx < 1){
                printf("That is out of bounds.\n");
                sleep (1);
                bx = bx - xcord(move, x);
                turns = turns - 1;
                }
                printf ("%.1lf, %.1lf\n", bx, by);
                sleep (1);
                Map(location, bx, by);
                turns = turns + 1;
                movement = 1;
            }
            
            else{
                printf ("That is not a valid direction.\n");
            }
        }
        movement = 0;
        
        if (bx >= 4.5 && bx <= 5.5 && by >= 4.5 && by <= 5.5){
            teleporter(location, turns);
            if (ready == "yes" || ready == "Yes"){
            break;    
            }
        }
        
        chance = randint(1,100);
        if (chance <= (0 ) ){
            if (location == "woods"){
                chance = randint (0, 2);
                foe = woodsFoe[chance];
                if (foe == "bug"){
                    fight(bug);
                    }
                else if (foe == "gup"){
                    fight(gup);
                    }
                else if (foe == "rock"){
                    fight(rock);
                    }
            }
            if (location == "jungle"){
                chance = randint (0, 2);
                foe = jungleFoe[chance];
                if (foe == "bees"){
                    fight(bees);
                    }
                else if (foe == "blood"){
                    fight(blood);
                    }
                else if (foe == "monke"){
                    fight(monke);
                    }
            }
            if (location == "desert"){
                chance = randint (0, 2);
                foe = desertFoe[chance];
                if (foe == "scorpion"){
                    fight(scorpion);
                    }
                else if (foe == "cactus"){
                    fight(cactus);
                    }
                else if (foe == "sandShark"){
                    fight(sandShark);
                    }
            }
            if (location == "sea"){
                chance = randint (0, 2);
                foe = seaFoe[chance];
                if (foe == "puffer"){
                    fight(puffer);
                    }
                else if (foe == "shark"){
                    fight(shark);
                    }
                else if (foe == "lobster"){
                    fight(lobster);
                    }
            }
            if (location == "sky"){
                chance = randint (0, 2);
                foe = skyFoe[chance];
                if (foe == "harpy"){
                    fight(harpy);
                    }
                else if (foe == "birds"){
                    fight(birds);
                    }
                else if (foe == "wyvern"){
                    fight(wyvern);
                    }
            }
            if (PHP == 0){
            break; 
            }
        }
    }
}



double xcord(string_t move, double x){
    if (move == "left" || move == "west"){
        move = "west";
        printf ("Moving %s.\n", move);
        sleep (1);
        x = x - 1;
        return x;
    }
    else if (move == "right" || move == "east"){
        move = "east";
        printf ("Moving %s.\n", move);
        sleep (1);
        x = x + 1;
        return x;
    }
    return 0;
};
double ycord(string_t move, double y){
    if (move == "up" || move == "north"){
        move = "north";
        printf ("Moving %s.\n", move);
        sleep (1);
        y = y + 1;
        return y;
    }
    else if (move == "down" || move == "south"){
        move = "south";
        printf ("Moving %s.\nw", move);
        sleep (1);
        y = y - 1;
        return y;
    }
    return 0;
}

void Map(string_t location, double bx, double by){
    CPlot plot;
    plot.title("Close to continue.");
    if (location == "woods"){
        plot.strokeColor("#752004");
        plot.strokeWidth(3);
        plot.fillColor("#2d820c");
        plot.rectangle(1,1, 5,5);
        plot.strokeWidth(4);
        plot.point(4, 2);
        plot.point(5, 3);
        plot.point(2, 4);
        plot.strokeColor("black");
        plot.strokeWidth(8);
        plot.point(5, 5);
        }
    if (location == "desert"){
        plot.strokeColor("orange");
        plot.strokeWidth(3);
        plot.fillColor("#ff983d");
        plot.rectangle(1,1, 5,5);
        plot.strokeWidth(4);
        plot.strokeColor("black");
        plot.strokeWidth(8);
        plot.point(5, 5);
        }
    if (location == "sky"){
        plot.strokeColor("#2aa6db");
        plot.strokeWidth(10);
        plot.fillColor("#cedade");
        plot.rectangle(1,1, 5,5);
        plot.strokeColor("black");
        plot.strokeWidth(8);
        plot.point(5, 5);
        }
    if (location == "sea"){
        plot.strokeColor("#242440");
        plot.strokeWidth(8);
        plot.fillColor("#355c96");
        plot.rectangle(1,1, 5,5);
        plot.strokeColor("black");
        plot.strokeWidth(8);
        plot.point(5, 5);
        }
    if (location == "jungle"){
        plot.strokeColor("#911e01");
        plot.strokeWidth(3);
        plot.fillColor("#54960c");
        plot.rectangle(1,1, 5,5);
        plot.strokeColor("black");
        plot.strokeWidth(8);
        plot.point(5, 5);
        }
    plot.strokeColor("red");
    plot.strokeWidth(2);
    plot.point(bx, by);
    plot.sizeRatio(1);
    plot.plotting();
    }

void fight(struct enemy s){
    printf ("\nA wild %s appeared!\n", s.name);
    sleep(p);
    printf ("Stats:\n%.0lf attack \n%.0f defense\n%.0f hp\n", s.Atk, s.Def, s.HP);
    sleep(p);
    printf("You have spend a total of ",turns," turns in this run.\n");
    sleep(p);
    EMHP=s.HP+(turns/2);
    EHP=s.HP+(turns/2);
    EDef=s.Def+(turns/2);
    EAtk=s.Atk;
    EAtkMax=s.Atk+(turns/2);
    EAtkMin=s.Atk-(3-turns/2);
    DefDamageCalc=EDef;
    PDefDamageCalc=PDef;
    while(EHP>0){
        printf("\nYou have ",PHP,"HP left.\n");
        playerturns();
        e = "true";
        if (EHP <= 0){
        printf("The %s is dying, but it makes one final attack.\n", s.name);
        }
        if (PT>=1){
            if (s.name == "Puffer fish"){
                PoisonDur = 0;
            }
            EHP=EHP-PoisonDur;
            PoisonDur=PoisonDur-1;
            printf("The %s takes %.0lf damage from the corrosion\n", s.name, PoisonDur); // Damage calculations Damage calculations Damage calculations Damage calculations Damage calculations 
            sleep(p);
        }
            TaisuT=0;
            PDod=randint(1,100);
            if (UIDodge=="True"){
                UIDodge=="False";
                Dodged="True";
            }
            if (DodgedAction=="True"){
                if (s.name = "Scorpion"){
                PDod = PDod - 12;
                }
                else {
                PDod = PDod - 7;
                }
            }
            if (PDod<=PAgi){
                Dodged="True";
            }
            EAtk=randint(EAtkMin, EAtkMax);
            while (e == "true"){
                attack = randint (1,2);
                if (attack == 1){
                    if (s.name == "Beetle" || s.name == "Gup" || s.name == "Gip" || s.name == "Geep" || s.name == "Sand shark" || s.name == "Monkey" || s.name == "Shark" || s.name == "Puffer fish" || s.name == "Stymphalian birds" || s.name == "Harpy" || s.name == "Wyvern" || s.name == "Mosquito"){
                        PDefDamageCalc=PDef-EAtk;
                        printf("\nThe %s attacks!\n", s.name);
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took damage! you have ",PHP," left.\n");
                            PDef = PDef - DefStacks;
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            sleep(p);
                        }
                        
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                    e = "false";
                    }
                    }
                    if (s.name == "Scorpion" || s.name == "Lobster"){
                        Dodged = "False";
                        PDefDamageCalc=PDef-(EAtk/2);
                        printf("The %s uses its claws to hold you in place!\n", s.name);
                        claws = "True";
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took damage! you have ",PHP," left.\n");
                            PDef = PDef - DefStacks;
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            sleep(p);
                        }
                        
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                        e = "false";
                        }
                    if (s.name == "Cactus"){
                        printf ("The %s is waiting for your next move.\n", s.name);
                        e = "false";
                        }
                    if (s.name == "Stone Golem"){
                        if (charge < 2){
                            charge = charge + 1;
                        }
                        if (charge = 2){
                            PDefDamageCalc=PDef-(EAtk*1.5);
                        printf("The Enemies attack damage was %.0lf\n", EAtk);
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took damage! you have %.0lf left.\n", PHP);
                            PDef = PDef - DefStacks;
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            sleep(p);
                        }
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                    e = "false";
                    }
                        }
                }
                if (attack == 2){
                    if (s.name == "Cactus" || s.name == "Stone Golem"){
                            EDef = EDef + (EDef/2);
                            printf ("The %s hardens its defenses", s.name);
                            e = "false";
                    if (s.name == "Scorpion" || s.name == "Swarm of Bees" || s.name == "Mosquito"){
                        PDefDamageCalc=PDef-(EAtk/2);
                        printf("The %s stung you!\n", s.name);
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took %.0lf damage!\n", PDefDamageCalc);
                            if (s.name = "Swarm of Bees"){
                            EPT = EPT + 1;
                            }
                            if (s.name == "Mosquito"){
                            EPT = EPT + 4;
                            EHP = EHP + (PDefDamageCalc/2);
                            printf ("The Mosquito sucked your blood!/n");
                            }
                            if (s.name == "Scorpion"){
                            EPT = EPT + (EAtk/4);
                            }
                            if (EPT > 0){
                                printf ("You are poisoned!");
                            }
                            else {
                                printf ("You blocked the poison!\n");
                            }
                            PDef = PDef - DefStacks;
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                                if (s.name = "Swarm of Bees"){
                                EPT = EPT + 0;
                                }
                                else if (s.name == "Mosquito"){
                                EPT = EPT + 2;
                                }
                                else if (s.name == "Scorpion"){
                                EPT = EPT + (EAtk/8);
                                }
                            if (EPT > 0){
                            printf ("You are poisoned!");
                            }
                            if (EPT == 0){
                            printf ("You blocked the poison!\n");
                            }
                            sleep(p);
                        }
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                    e = "false";
                        }
                }      
            }
            printf("You have ", PHP," HP left.\n");
            if (CounterSpiritStance=="True"){
                CounterSpiritStance="False";
                DefDamageCalc=EAtk-(EAtk*4);
                printf("The counter did ",DefDamageCalc," damage\n");
                sleep(p);
                if (DefDamageCalc<0){
                    EHP=EHP+DefDamageCalc;
                    printf("You successfully countered!\n");
                    sleep(p);
                }
                else{
                    printf("You did not counter anything.\n");
                    sleep(p);
                }
            }
            else if (CounterStance=="True"){
                CounterStance="False";
                DefDamageCalc=EAtk-(EAtk*2);
                printf("The counter did ",DefDamageCalc," damage\n");
                sleep(p);
                if (DefDamageCalc<0){
                    EHP=EHP+DefDamageCalc;
                    
                    printf("You successfully countered!\n");
                    sleep(p);
                }
            }
            if (PHP<=0){
                lose(turns);
                break;
            }
            PDef=PMaxDef;
            DualBlades=0;
            TrueAction="False";
            if (EHP > EMHP){
                EHP = EMHP;
            }
        if (EHP<=0){
            printf("The %s is defeated!\n", s.name);
            sleep(p);
            if (s.name == "Swarm of Bees" || s.name == "Stymphalian birds"){
                chance = randint (1, 2);
                if (chance == 2){
                    if (s.name == "Swarm of Bees"){
                        fight(bees);
                    }
                    else if (s.name == "Stymphalian birds"){
                        fight(birds);
                    }
                }
            }
            if (foe == "gup"){
                printf("The Gup has been weakened, and shrinks to an even smaller form,\n");
                sleep(p);
                printf("a Geep.\n");
                sleep(p);
                foe = "geep";
                fight(geep);
            }
            if(foe == "geep"){
                printf("The Geep has been weakened, and shrinks to its smallest and most pitiful form,\n");
                sleep(p);
                printf("a Gip.\n");
                sleep(p);
                foe = "gip";
                fight(gip);
            }	
            if (foe == "gip"){
                if (slime == 1){
                printf("As you deal the final blow to the Gip,\n");
                sleep(p);
                printf("it shrinks down into a puddle, unresponsive.\n");
                sleep(p);
                winEnd(gorp, turns, name, weapon);
                }
            }
            turns=turns+1;
            claws = "False";
            killed();
            break;
        }
    }
}
void boss(struct boss s){
    printf ("Stats:\n%.1lf attack \n%.1lf defense\n%.1lf hp\n", s.Atk, s.Def, s.HP);
    sleep(p);
    printf("You have spent a total of ",turns," turns in this run.\n");
    sleep(p);
    EMHP=s.HP;
    EHP=s.HP;
    EDef=s.Def;
    EAtk=s.Atk;
    EAtkMax=s.Atk+(turns/2);
    EAtkMin=s.Atk-(3-turns/2);
    DefDamageCalc=EDef;
    PDefDamageCalc=PDef;
    while(EHP>0){
        playerturns();
        e = "true";
        if (EHP <= 0){
            printf("The %s is dying, but it makes one final attack.\n", s.name);
        }
            PDod=randint(1,100);
            if (DodgedAction=="True"){
                PDod = PDod - 7;
            }
            if (PDod<=PAgi){
                Dodged="True";
            }
            if (UIDodge=="True"){
                UIDodge=="False";
                PDod=PDod-(95-HB*2);
            }
            if (PT>=1){
                EHP=EHP-PoisonDur;
                PoisonDur=PoisonDur-1;
                printf("The enemy takes damage from the corrosion\n"); // Damage calculations Damage calculations Damage calculations Damage calculations Damage calculations 
                sleep(p);
            }
            TaisuT=0;
            EAtk=randint(EAtkMin, EAtkMax);
            while (e == "true"){
                if (EHP<11){
                    if (s.name == "Vagrant" || s.name == "Sun"){
                        if (VNuke==0){
                            printf("The %s is charging up a massive attack, you need to do something soon!\n", s.name);
                            sleep(p);
                            Phase=20;
                            VNuke=VNuke+1;
                            e = "false";
                        }
                        if (VNuke==1){
                            printf("The attack is still charging, you still have time.\n");
                            sleep(p);
                            VNuke=VNuke+1;
                            e = "false";
                        }
                        else if (VNuke==2){
                            printf("The attack is still charging, you still have time.\n");
                            VNuke=VNuke+1;
                            e = "false";
                        }
                        else if (VNuke==3){
                            printf("The attack is almost ready!\n");
                            VNuke=VNuke+1;
                            e = "false";
                        }
                        else if (VNuke==4){
                            printf("The attack was launched, you see an enveloping light cover everything in the vicinity.\n");
                            sleep(p);
                            PHP=PHP-PHP;
                            e = "false";
                        }
                    }
                }
                attack = randint (1,3);
                if (attack == 1){
                    if (s.name == "Gorp" || s.name == "Queen Bee" || s.name == "Gorilla" || s.name == "Deathbloom" || s.name == "Sand worm" || s.name == "Sphinx" || s.name == "Sun" || s.name == "Bahamut" || s.name == "Leviathan" || s.name == "Hydra"){
                        PDefDamageCalc=PDef-EAtk;
                        printf("The Enemies attack damage was %.0lf\n", EAtk);
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took damage! you have %.0lf left.\n", PHP);
                            PDef = PDef - DefStacks;
                            if (s.name == "Hydra" || s.name == "Queen Bee"){
                                EPT = EPT + 5;
                                printf ("The %s poisoned you with its venom!\n", s.name);
                                sleep(p);
                            }
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            if (s.name == "Hydra" || s.name == "Queen Bee"){
                                EPT = EPT + 5;
                                printf ("The %s poisoned you with its venom!\n", s.name);
                            }
                            sleep(p);
                        }
                        
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                    e = "false";
                    }
                    if (s.name == "Queen Beetle"){
                        Dodged = "False";
                        PDefDamageCalc=PDef-(EAtk/2) + (minions*3);
                        printf("The %s uses its claws to hold you in place!\n", s.name);
                        claws = "True";
                        sleep(p);
                        }
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                            printf("You took damage! you have ",PHP," left.\n");
                            PDef = PDef - DefStacks;
                            DefStacks = 0;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            sleep(p);
                        }
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                    e = "false";
                    }
                }
            if (attack == 2){
                if (s.name == "Vagrant"){
                    while (VAtkT<3){
                        PDefDamageCalc=PDef-EAtk;
                        PDefDamageCalc=PDefDamageCalc+2;
                        printf("The Enemies attack damage was %s\n", EAtk);
                        sleep(p);
                        if (PDefDamageCalc<0&&Dodged=="False"){
                            PHP=PHP+PDefDamageCalc;
                        }
                        else if (PDefDamageCalc>0&&Dodged=="False"){
                            printf("%s blocked the attack!\n", weapon);
                            PHP=PHP-1;
                            sleep(p);
                        }
                        else{
                            printf("You dodged the attack\n");
                            sleep(p);
                            Dodged="False";
                        }
                        VAtkT=VAtkT+1;
                    }
                VAtkT=0;
                }
                if (s.name == "Queen Beetle"){
                minions=minions+3;
                printf("The Queen Beetle summons 2 beetles.\n");
                sleep(p);
                }
                if (s.name == "Queen Bee"){
                minions=minions+5;
                printf("The Queen Beetle summons 5 bees.\n");
                sleep(p);
                }
            }

            if (attack == 3){
                if (s.name == "Vagrant" || s.name == "Sun"){
                printf("The %s just floats there.\n", s.name);
                sleep(p);
                }
            }
            if (CounterSpiritStance=="True"){
                CounterSpiritStance="False";
                DefDamageCalc=EAtk-(EAtk*4);
                printf("The counter did ",DefDamageCalc," damage\n");
                sleep(p);
                if (DefDamageCalc<0){
                    EHP=EHP+DefDamageCalc;
                    printf("You successfully countered!\n");
                    sleep(p);
                }
                else{
                    printf("You did not counter anything.\n");
                    sleep(p);
                }
                
            }
            else if (CounterStance=="True"){
                CounterStance="False";
                DefDamageCalc=EAtk-(EAtk*2);
                printf("The counter did ",DefDamageCalc," damage\n");
                sleep(p);
                if (DefDamageCalc<0){
                    EHP=EHP+DefDamageCalc;
                    
                    printf("You successfully countered!\n");
                    sleep(p);
                }
            }
            if (PHP<=0){
                lose();
                break;
            }
            if (s.name == "Hydra"){
            EHP = EHP + (EHP/10);
            printf ("The Hydra regenerates itslef!\n");    
            }
            PDef=PMaxDef;
            DualBlades=0;
            printf("You have ",PHP," HP.\n");
            sleep(p);
            TrueAction="False";
    }
    if (EHP<=0){
        printf("The %s is defeated!\n", s.name);
        sleep(p);
        claws = "false";
        if (foe == "gorp"){
        printf("The Gorp has been weakened, and shrinks to a smaller form,\n");
        sleep(p);
        printf("a Gup.\n");
        sleep(p);
        slime=1;
        fight(gup);
        }
        killed();
    PHP=PHP+2;
    }
    if (PHP>PHPMax){
        PHP=PHPMax;
    }
    printf("You have ",PAtk," Attack, ",PDef," Defence, and ",PHP, "HP\n");
    sleep(p);
}

int playerturns(){
    if (Technique=="dual"){
        if (DualLvl==1){
            PAtk=PAtk/4;
        }
        else if (DualLvl==3){
            PAtk=PAtk/2;
        }
        while (DualBlades<4){
            if (DualLvl>=2&&TaisuT==0){
                DualBlades=0-2;
                TaisuT=1;
            }
            printf("What do you do? (Attack, Block, or Dodge)\n"); 
            scanf("%s",&Action);
            if (Action=="Attack"||Action=="attack"){
                Crit=randint(1,100);
                DualBlades=DualBlades+1;
                if (UnlimitedCritWorks>1){
                    CritCount=CritCount+1;
                    PAtk=PAtk*(UnlimitedCritWorks+CritCount*0.5);
                    DefDamageCalc = EDef - PAtk;
                    PAtk=PAtkMax;
                    printf("You landed a critical!\n");
                    sleep(p);
                }
                else if (Crit<PLuk){
                    if (Crit<=PLuk){
                        Critical="True";
                        printf("You landed a critical!\n");
                        sleep(p);                        
                    }
                    if (Critical=="True"){
                        DefDamageCalc=EDef-(PAtk*2);
                        Critical = "False";
                    }
                }
                hit();
                if (PT>1){
                PoisonDur=PoisonDur+PT;
                }
                TrueAction="True";
                printf("The enemy has %.0lfHP left.\n", EHP);
                sleep(p);
                Action="False";
            }
            else if (Action=="Dodge"||Action=="dodge"){
                if (claws != "True"){
                    if (DualLvl>=3){
                        UIDodge="True";
                        DualBlades=DualBlades+1;
                        TrueAction="True";
                        Action="False";
                    }
                    else{
                        TrueAction="True";
                        Action="False";
                        DodgedAction="True";
                        DualBlades=DualBlades+1;
                    }
                }
                else{
                    if (foe = "lobster"){
                    printf ("The Lobster is holding you in place with its claws!\n");
                    sleep(p);
                    }
                    else if (foe = "scorpion"){
                    printf ("The Scorpion is holding you in place with its claws!\n");
                    sleep(p);
                    }
                    else if (foe = "bigBug"){
                    printf ("The Queen Beetle is holding you in place with its claws!\n");
                    sleep(p);
                    }
                Action = "False";
                }
                printf("The enemy has ",EHP," HP left\n");
                sleep(p);
            }
            else if (Action=="Block"||Action=="block"){
                DefStacks = DefStacks + 5;
                PDef=PDef+DefStacks;
                TrueAction="True";
                Action="False";
                DualBlades=DualBlades+1;
            }
            else{
                printf("Please select one of the options\n");
                sleep(p);
            }
        }
        
        return 0;
    }
    
    if (Technique=="katana"){
        while(TrueAction == "False"){
                printf("What do you do? (Attack, Block, Dodge, or Special)\n"); //katana technique katana technique katana technique katana technique katana technique katana technique katana technique katana technique 
                scanf("%s",&Action);
                if (Action=="Attack"||Action=="attack"){
                    if (Sheathed=="True"){
                        Spirit="True";
                        Sheathed="False";
                    }
                    Crit=randint(1,100);
                    if (UnlimitedCritWorks>1){
                        CritCount=CritCount+1;
                        PAtk=PAtk*(UnlimitedCritWorks+CritCount*0.5);
                        DefDamageCalc=EDef-PAtk;
                        PAtk=PAtkMax;
                        printf("You landed a critical!\n");
                        sleep(p);
                    }
                    else if (Crit<PLuk){
                        if (Crit<=PLuk){
                            Critical="True";
                            printf("You landed a critical.\n");
                            sleep(p);
                        }
                        if (Critical=="True"){
                            DefDamageCalc=EDef-(PAtk*2);
                            Critical="False";
                        }
                    }
                    else{
                        DefDamageCalc=EDef-PAtk;
                    }
                    if (PT>=1){
                        PoisonDur=PoisonDur+PT;
                    }
                    hit();
                    TrueAction="True";
                    printf("The enemy has ",EHP," HP left\n");
                    sleep(p);
                    Action="False";
                }
                else if (Action=="Dodge"||Action=="dodge"){
                    if (claws != "True"){
                        if (DualLvl>=3){
                            UIDodge="True";
                            DualBlades=DualBlades+1;
                            TrueAction="True";
                            Action="False";
                        }
                        else{
                            TrueAction="True";
                            Action="False";
                            DodgedAction="True";
                            DualBlades=DualBlades+1;
                        }
                    }
                    else{
                        if (foe = "lobster"){
                        printf ("The Lobster is holding you in place with its claws!\n");
                        sleep(p);
                        }
                        else if (foe = "scorpion"){
                        printf ("The Scorpion is holding you in place with its claws!\n");
                        sleep(p);
                        }
                        else if (foe = "bigBug"){
                        printf ("The Queen Beetle is holding you in place with its claws!\n");
                        sleep(p);
                        }
                    Action = "False";
                    }
                }
                else if (Action=="Block"||Action=="block"){
                    DefStacks = DefStacks + 5;
                    PDef=PDef+DefStacks;
                    TrueAction="True";
                    Action="False";
                }
                else if (Action=="Special"||Action=="special"){
                    printf("The specials for the katana are Sheath, Slash, Counter, and Dash.\n");
                    sleep(p);
                    printf("Note that basic attack can be used in Sheath to gain \"Spirit\", or a buff to Slash, Counter, and Dash.\n","Other abilities can only be used if Sheath is in effect.\n");
                    sleep(p);
                    if (katanaLvl>2){
                        Spirit="True";   
                    }
                    if (Sheathed=="True"){
                        printf("You have Sheathed buff, you can use the other abilities.\n");
                        sleep(p);
                    }
                    if (Spirit=="True"){
                        printf("You have Spirit Buff, your sheath abilities are stronger.\n");
                        sleep(p);
                    }
                    scanf("%s",&katana);
                    TrueAction="True";
                    if (katana=="Sheath"||katana=="sheath"){
                        Sheathed="True";
                        PDef=PDef+3;
                        TrueAction="True";
                    }
                    else if (katana=="Slash"||katana=="slash"){
                        if (Sheathed=="True"){
                            Sheathed="False";
                            if (Spirit=="True"){
                                PAtk=PAtk*3;
                                Spirit="False";
                            }
                            Crit=randint(1,100);
                            if (UnlimitedCritWorks>1){
                                CritCount=CritCount+1;
                                PAtk=PAtk*(UnlimitedCritWorks+CritCount*0.5);
                                DefDamageCalc=EDef-PAtk;
                                PAtk=PAtkMax;
                                printf("You landed a critical!\n");
                                sleep(p);
                            }
                            else if (Crit<=PLuk){
                                if (Crit<=PLuk){
                                    Critical="True";
                                    printf("You landed a critical.\n");
                                    sleep(p);
                                }
                                if (Critical=="True"){
                                    DefDamageCalc=EDef-(PAtk*2);
                                    Critical="False";
                                }
                            }
                            else{
                                DefDamageCalc=EDef-PAtk;
                            }
                            if (PT>1){
                                PoisonDur=PoisonDur+PT;
                            }
                            hit();
                            TrueAction="True";
                            printf("The enemy has ",EHP," HP left\n");
                            sleep(p);
                            Action="False";
                            PAtk=PAtkMax;
                        }
                        else if (katanaLvl>=2){
                            if (Spirit=="True"){
                                PAtk=PAtk*3;
                                Spirit="False";
                            }
                            Crit=randint(1,100);
                            if (UnlimitedCritWorks>1){
                                CritCount=CritCount+1;
                                PAtk=PAtk*(UnlimitedCritWorks+CritCount*0.5);
                                DefDamageCalc=EDef-PAtk;
                                PAtk=PAtkMax;
                                printf("You landed a critical!\n");
                                sleep(p);
                            }
                            else if (Crit<=PLuk){
                                if (Crit<=PLuk){
                                    Critical="True";
                                    printf("You landed a critical.\n");
                                    sleep(p);
                                }
                                if (Critical=="True"){
                                    DefDamageCalc=EDef-(PAtk*2);
                                    Critical="False";
                                }
                            }
                            else{
                                DefDamageCalc=EDef-PAtk;
                            }
                            printf(DefDamageCalc,"\n");
                            if (PT>1){
                                PoisonDur=PoisonDur+PT;
                            }
                            hit();
                            TrueAction="True";
                            printf("The enemy has ",EHP," HP left\n");
                            sleep(p);
                            Action="False";
                            PAtk=PAtkMax;
                        }
                        else{
                            printf("You need to be sheathed.\n");
                            sleep(p);
                        }
                    }
                    else if (katana=="Counter"||katana=="counter"){
                        if (Sheathed=="True"){
                            Sheathed="False";
                            if (Spirit=="True"){
                                CounterSpiritStance="True";
                            printf("You are ready to counter strike.\n");
                                sleep(p);
                                Spirit="False";
                            }
                            else{
                                CounterStance="True";
                                printf("You are ready to counter strike.\n");
                                sleep(p);
                            }
                            TrueAction="True";
                        }
                        else if (katanaLvl>1){
                            Sheathed="False";
                            if (Spirit=="True"){
                                CounterSpiritStance="True";
                                printf("You are ready to counter strike.\n");
                                sleep(p);
                                Spirit="False";
                            }
                            else{
                                CounterStance="True";
                                printf("You are ready to counter strike.\n");
                                sleep(p);
                            }
                            TrueAction="True";
                        }
                        else{
                            printf("You need to be sheathed.\n");
                            sleep(p);
                        }
                    }
                    else if (katana=="Dash"||katana=="dash"){
                        if (Sheathed=="True") {
                            Sheathed="False";
                            if (Spirit=="True"){
                                Spirit="False";
                                PAtk=PAtk*2;
                            }
                            DodgedAction="True";
                            TrueAction="True";
                        }
                        else if (katanaLvl>1){
                            Sheathed="False";
                            if (Spirit=="True"){
                                Spirit="False";
                                PAtk=PAtk*2;
                            }
                            DodgedAction="True";
                            TrueAction="True";
                        }
                        else{
                            printf("You need to be sheathed.\n");
                            sleep(p);
                        }
                    }
                    else{
                        printf("Please select one of the options.\n");
                        sleep(p);
                    }
                }
                else{
                    printf("Please select one of the options\n");
                    sleep(p);
                }
        }
        if (EAgi > EAgiMax){
            EAgi = EAgiMax;
        }
    }
    
    else if (Technique == "sword"){
        while (TrueAction == "False"){
            printf("What do you do? (Attack, Block, or Dodge)\n"); //No technique No technique No technique No technique No technique No technique No technique No technique 
            scanf("%s",&Action);
            if (Action=="Attack"||Action=="attack"){
                Crit=randint(1,100);
                DualBlades=DualBlades+1;
                if (UnlimitedCritWorks>1){
                    CritCount=CritCount+1;
                    PAtk=PAtk*(UnlimitedCritWorks+CritCount*0.5);
                    DefDamageCalc=EDef-PAtk;
                    PAtk=PAtkMax;
                    printf("You landed a critical!\n");
                    sleep(p);
                }
                else if (Crit<PLuk){
                    if (Crit<=PLuk){
                        Critical="True";
                        printf("You landed a critical!\n");
                        sleep(p);
                    }
                    if (Critical=="True"){
                        DefDamageCalc=EDef-(PAtk*2);
                        Critical="False";
                    }
                }
                else{
                    DefDamageCalc=EDef-PAtk;
                }
                if (PT>=1){
                    PoisonDur=PoisonDur+PT;
                }
                hit();
                TrueAction="True";
                printf("The enemy has %.0lf HP left.\n", EHP);
                sleep(p);
                Action="False";
            }
            else if (Action=="Dodge"||Action=="dodge"){
                printf("The enemy has %.0lf HP left\n", EHP);
                sleep(p);
                TrueAction="True";
                Action="False";
                DodgedAction="True";
            }
                else{
                    if (foe = "lobster"){
                    printf ("The Lobster is holding you in place with its claws!\n");
                    sleep(p);
                    }
                    else if (foe = "scorpion"){
                    printf ("The Scorpion is holding you in place with its claws!\n");
                    sleep(p);
                    }
                    else if (foe = "bigBug"){
                    printf ("The Queen Beetle is holding you in place with its claws!\n");
                    sleep(p);
                    }
                    Action = "False";
                }
            if (Action=="Block"||Action=="block"){
                PDef=PDef+5;
                TrueAction="True";
                Action="False";
            }
            else{
                printf("Please select one of the options\n");
                sleep(p);
            }
        }
    }
    return 0;
}

string_t teleporter(string_t location, int turns){
    printf("You can activate the nearby portal, but it will summon the stage's boss.\n Are you ready?\n");
    scanf("%s", &ready);
    if (ready == "yes" || ready == "Yes"){
        printf("As the teleporter activates, the ground beneath you shakes.\n");
        if (location == "woods"){
                chance = randint (0, 2);
                foe = woodsBoss[chance];
                if (foe == "bigBug"){
                    printf("From the earth, a beetle arises,\n");
                    sleep(p);
                    printf("far larger than the ones you have seen before appears.\n");
                    sleep(p);
                    printf("The Queen of the beetles.\n");
                    sleep(p);
                    printf("Now, it is the only thing that stands before you and your only escape.\n");
                    sleep(p);
                    boss(bigBug);
                    }
                else if (foe == "gorp"){
                    printf("An orange blob, easily the size of a house falls from the trees.\n");
                    sleep(p);
                    printf("You would normally call it a slime, but only one word comes to mind.\n");
                    sleep(p);
                    printf("Gorp.\n");
                    sleep(p);
                    boss(gorp);
                    }
                else if (foe == "vagrant"){
                    printf("Suddenly, electricity gathers into a single point.\n");
                    sleep(p);
                    printf("From this convergence of energy, a shape begins to form.\n");
                    sleep(p);
                    printf("A jellyfish, its translucent figure surging with electricity.\n");
                    sleep(p);
                    printf("The Vagrant is the only thing that stands before you and your only escape.\n");
                    sleep(p);
                    boss(vagrant);
                    }
            }
            if (location == "jungle"){
                chance = randint (0, 2);
                foe = jungleBoss[chance];
                if (foe == "bigBee"){
                    printf("The largest hive you have ever seen erupts from the ground.\n");
                    sleep(p);
                    printf("From the entrance, the grandest of bees emerges.\n");
                    sleep(p);
                    printf("The Queen Bee is all that is left in your way.\n");
                    sleep(p);
                    boss(bigBee);
                    }
                else if (foe == "gorilla"){
                    printf("From the trees,\n");
                    sleep(p);
                    printf("The mightiest of the apes appears.\n");
                    sleep(p);
                    printf("The Gorilla is all that stands in your way..\n");
                    sleep(p);
                    boss(gorilla);
                    }
                else if (foe == "death"){
                    printf("From the Jungle’s fertile soil,\n");
                    sleep(p);
                    printf("A strange plant with whip-like tendrils emerges,\n");
                    sleep(p);
                    printf("its exotic colors are near hypnotic.\n");
                    sleep(p);
                    printf("The Deathbloom refuses to leave your path.\n");
                    sleep(p);
                    boss(death);
                    }
            }
            if (location == "desert"){
                chance = randint (0, 2);
                foe = desertBoss[chance];
                if (foe == "worm"){
                    printf("From beneath the shifting sands,\n");
                    sleep(p);
                    printf("A colossal worm burrows its way around,\n");
                    sleep(p);
                    printf("its rows of teeth look as if they could shred you like paper.\n");
                    sleep(p);
                    printf("The Sandworm is all that is in the way of your freedom.\n");
                    sleep(p);
                    boss(worm);
                    }
                else if (foe == "sun"){
                    printf("From the sky,\n");
                    sleep(p);
                    printf("The Sun begins to fall,\n");
                    sleep(p);
                    printf("As it does, the temperature quickly rises.\n");
                    sleep(p);
                    printf("It stops right before it hits the ground, now in your way.\n");
                    sleep(p);
                    boss(sun);
                    }
                else if (foe == "sphinx"){
                    boss(sphinx);
                    }
            }
            if (location == "sea"){
                chance = randint (0, 2);
                foe = seaBoss[chance];
                if (foe == "bahamut"){
                    printf("Above, from the surface of the water,\n");
                    sleep(p);
                    printf("A massive shadow looms over you.\n");
                    sleep(p);
                    printf("A grand whale blocking the sun itself,\n");
                    sleep(p);
                    printf("Bahamut now blocks your path.\n");
                    sleep(p);
                    boss(bahamut);
                    }
                else if (foe == "serpent"){
                    printf("In the distance,\n");
                    sleep(p);
                    printf("A long dark figure rushes towards you.\n");
                    sleep(p);
                    printf("A colossal serpent of the seas intrudes upon your path.\n");
                    sleep(p);
                    printf("You now face the Leviathan in its very home.\n");
                    sleep(p);
                    boss(serpent);
                    }
                else if (foe == "hydra"){
                    printf("From the depths,\n");
                    sleep(p);
                    printf("A several serpentine heads sprout from the shadows.\n");
                    sleep(p);
                    printf("Pairs branching off of a single neck each.\n");
                    sleep(p);
                    printf("The Hydra, the serpent of infinite heads faces you.\n");
                    sleep(p);
                    boss(hydra);
                    }
            }
            if (location == "sky"){
                chance = randint (0, 2);
                foe = skyBoss[chance];
                if (foe == "wyrm"){
                    boss(wyrm);
                    }
                else if (foe == "eagle"){
                    boss(eagle);
                    }
                else if (foe == "sky"){
                    boss(sky);
                    }
            }
        else if (ready == "no" || ready == "No"){
            printf("Then come back when you are ready\n");
            sleep (1);
            printf("but be warned\n");
            sleep (1);
            printf("the longer you stay here,\n");
            sleep (1);
            printf("the tougher the boss will be.\n");
            sleep (1);
        }
    }
    return "null";
}

int hit(){
    EDodge=randint(1,100);
    if (foe == "mosquito"){
        EAgi = 80;
    }
    if (EAgi>=EDodge){
            EDodged="True";
    }
    DefDamageCalc = EDef - PAtk;
    if (DefDamageCalc<0&&EDodged!="True"){
        printf("You attack the enemy with %s.\n", weapon);
        if (DefDamageCalc>=0&&EDodged!="True"){
        EHP=EHP-1;
        printf("The enemy blocked!\n");
        }
        else if (EDodged=="True"&&Spirit!="True"){
            printf("The enemy dodged!\n");
        }
        else{
            EHP=EHP+DefDamageCalc;
            printf("Your attack hit!\n");
        }
        if (foe == "cactus"){
            Dmg = EAtk + (DefDamageCalc/2);
            PDefDamageCalc=PDef-Dmg;
            printf("The Cactus hurts you with its thorns!\n");
            sleep(p);
            if (PDefDamageCalc<0&&Dodged=="False"){
                PHP=PHP+PDefDamageCalc;
                printf("You took %.0lf damage!\n", PDefDamageCalc);
            }
            else if (PDefDamageCalc>0&&Dodged=="False"){
                printf("The enemy blocks your attack!\n");
                EHP=EHP-1;
                sleep(p);
            }
        }
        if (foe == "puffer"){
            EPT = EPT + 3;
            printf("The puffer fish poisoned you in retaliation!\n");
            sleep(p);
        }
        if (foe == "hydra"){
            chance = randint(1,2);
            if (chance == 1){
            EPT = EPT + 4;
            printf("The Hydra's poisonous blood makes contact with your skin!\n");
            }
        }
        if (minions > 0){
            minions = minions - DefDamageCalc;
            if (foe == "bigBug"){
            printf("Your attack also killed the Queen Beetle's minions!\n");
            sleep(p);
            }
            if (foe == "bigBee"){
            printf("Your attack also killed the Queen Beetle's minions!\n");
            sleep(p);
            }
            if (minions < 0){
            printf("You killed all of the minions.\n");
            sleep(p);
            }
        }
    }
    EDodged = "False";
    return 0;
}

void lose(){
    if (turns > 100){
        printf ("\nSomehow, you chose to stay for quite some time, and yet you are still dead.\n");
        sleep (5);
        printf ("ENDING: Slow and Painful\n");
        sleep (1);
        printf ("GAME OVER\n");
    }
    if (turns > 50){
        printf ("\nDespite your time and effort, you are still dead, was it all worth it?\n");
        sleep (5);
        printf ("ENDING: A Good Effort, But Not Enough\n");
        sleep (1);
        printf ("GAME OVER\n");
    }
    if (turns < 10){
        printf ("\nMight've done better if you had slowed down.\n");
        sleep (5);
        printf ("ENDING: Fast Food\n");
        sleep (1);
        printf ("GAME OVER\n");
    }
}
    
void winEnd (struct boss s, int turns, string_t name, string_t weapon){
    printf ("\nWith the guardian of the teleporter defeated, you enter a portal from the telporter.\n");
    sleep(p);
        if (turns > 100 && turns ){
            printf("\nYou took your sweet time and it finally payed off, you defeated the %s, and have gone through the teleporter, hope you enjoyed the game!\n", s.name);
            printf("ENDING: Well Prepared\n");
            printf("Thanks for playing, ", name, "!\n");
            printf("THE END\n");
        }
        if (turns > 50){
            printf ("Congratulations, you beat the game with your sword, %s!\n", name, weapon);
            printf ("ENDING: Average\n");
            printf("Thanks for playing, ", name, "!\n");
            printf ("THE END\n");
        }
        if (turns < 10){
            printf ("You got in quick, and got out faster, congrats, it probably took you more time to name %s.\n", weapon);
            printf ("ENDING: SpeedRunner\n");
            printf("Thanks for playing, ", name, "!\n");
            printf ("END\n");
        }
    return;
}

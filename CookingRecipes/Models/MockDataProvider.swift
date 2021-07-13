//
//  MockDataProvider.swift
//  CookingRecipes
//
//  Created by Victoriia Nestrugina on 7/13/21.
//

import Foundation
import RealmSwift

final class MockDataProvider {
    
    static func provideMockData() -> Profile {
        var recipes: [Recipe] = []
        
        var title = "Easy homemade pickle"
        var ingredients = ["400 g crunchy veg, such as radishes, carrots, red onion, cauliflower, cucumber",
                           "250 ml vinegar , such as white wine, red wine or cider",
                           "1 tablespoon sea salt",
                           "1 tablespoon caster sugar",
                           "fresh dill , optional",
                           "mustard seeds , optional"]
        var method = """
                Cut or slice up the veg into fine or chunky pieces, depending on what you’re looking for.
                I quite like purposely cutting each veg differently – some diced, some into erratic chunks, some sliced delicately and some more thickly.
                Place all the veg in a sterilised airtight jar, add 125ml of water, along with the vinegar, salt, sugar and herbs and spices, if using.
                Close the lid and give it a good shake.
                Keep in the fridge for up to 8 weeks, or you can absolutely use it right away – it will start off tasting quite sharp and crunchy, then relax into itself over a period of a few weeks.
                This pickle is brilliant in sandwiches and salads, on a cheese board, or as a side to curries and stir-fries.
            """
        var type = DishType.side
        var image = UIImage(named: "EasyHomemadePickle")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "Chorizo & pear red cabbage"
        ingredients = ["150 g quality chorizo",
                        "2 teaspoons fennel seeds",
                        "1 red onion",
                        "1 red cabbage , (1kg)",
                        "1 x 410 g tin of sliced pears , in natural juice"]
        method = """
            Roughly dice the chorizo and place into a large casserole pan on a medium heat. Cook for a few minutes, or until the chorizo has released its oils, then add the fennel seeds. Peel and finely slice the red onion, add to the pan and cook for a few minutes, or until softened and smelling amazing.

            Click away any tatty outer leaves from the red cabbage, trim the base, then cut into wedges and roughly slice. Add to the pan with a swig of red wine vinegar, and a pinch of sea salt and black pepper. Cook with the lid ajar on a low heat for 10 minutes, stirring frequently. Add the tinned pears, with some of the juice, and continue cooking for a further 10 minutes, or until the cabbage is tender.
            """
        type = DishType.side
        image = UIImage(named: "ChorizoRearRedCabbage")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))

        title = "Beautiful courgette carbonara"
        ingredients = ["6 medium green and yellow courgettes",
                        "500 g penne",
                        "4 large free-range eggs",
                        "100 ml single cream",
                        "1 small handful of Parmesan cheese",
                        "olive oil",
                        "6 slices of higher-welfare back bacon",
                        "½ a bunch of fresh thyme , (15g)",
                        "a few courgette flowers , (optional)"]
        method = """
            Put a large pan of salted water on to boil.
            Halve and then quarter any larger courgettes lengthways. Cut out and discard any fluffy middle bits, and slice the courgettes at an angle into pieces roughly the same size and shape as the penne. Smaller courgettes can simply be sliced finely.
            Your water will now be boiling, so add the penne to the pan and cook according to the packet instructions.
            To make your creamy carbonara sauce, separate the eggs and put the yolks into a bowl (saving the whites for another recipe). Add the cream and grate in half the Parmesan, and mix together with a fork. Season lightly with sea salt and black pepper, and put to one side.
            Heat a very large frying pan (a 35cm one is a good start – every house should have one!) and add a good splash of olive oil. Cut the pancetta or bacon into chunky lardons and fry until dark brown and crisp.
            Add the courgette slices and 2 big pinches of black pepper, not just to season but to give it a bit of a kick. Pick, chop and sprinkle in the thyme leaves (reserving any flowers), give everything a stir, so the courgettes become coated with all the lovely bacon-flavoured oil, and fry until they start to turn lightly golden and have softened slightly.
            It’s very important to get this next bit right or your carbonara could end up ruined. You need to work quickly. When the pasta is cooked, drain it, reserving a little of the cooking water. Immediately, toss the pasta in the pan with the courgettes, bacon and lovely flavours, then remove from the heat and add a ladleful of the reserved cooking water and your creamy sauce. Stir together quickly. (No more cooking now, otherwise you’ll scramble the eggs.)
            Get everyone around the table, ready to eat straight away. While you’re tossing the pasta and sauce, grate in the rest of the Parmesan and add a little more of the cooking water if needed, to give you a silky and shiny sauce. Taste quickly for seasoning.
            If you’ve managed to get any courgette flowers, tear them over the top, then serve and eat immediately, as the sauce can become thick and stodgy if left too long.
            """
        type = DishType.mainCourse
        image = UIImage(named: "BeautifulCourgetteCarbonara")!
       
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "Perfect roast beef"
        ingredients = ["1.5 kg topside of beef",
            "2 medium onions",
            "2 carrots",
            "2 sticks celery",
            "1 bulb of garlic",
            "1 bunch of mixed fresh herbs , such as thyme, rosemary, bay, sage",
            "olive oil"]
        method = """
            Remove the beef from the fridge 30 minutes before you want to cook it, to let it come up to room temperature.
            Preheat the oven to 240°C/475°F/ gas 9.
            Wash and roughly chop the vegetables – there’s no need to peel them. Break the garlic bulb into cloves, leaving them unpeeled.
            Pile all the veg, garlic and herbs into the middle of a large roasting tray and drizzle with oil.
            Drizzle the beef with oil and season well with sea salt and black pepper, then rub all over the meat. Place the beef on top of the vegetables.
            Place the tray in the oven, then turn the heat down immediately to 200°C/400°F/gas 6 and cook for 1 hour for medium beef. If you prefer it medium-rare, take it out 5 to 10 minutes earlier. For well done, leave it in for another 10 to 15 minutes.
            If you’re doing roast potatoes and veggies, this is the time to crack on with them – get them into the oven for the last 45 minutes of cooking.
            Baste the beef halfway through cooking and if the veg look dry, add a splash of water to the tray to stop them from burning.
            When the beef is cooked to your liking, take the tray out of the oven and transfer the beef to a board to rest for 15 minutes or so. Cover it with a layer of tin foil and a tea towel and leave aside while you make your gravy, horseradish sauce and Yorkshire puddings.
            """
        type = DishType.mainCourse
        image = UIImage(named: "PerfectRoastBeef")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "Chocolate orange shortbread"
        ingredients = ["150 g unsalted butter , at room temperature",
            "200 g plain flour",
            "50 g golden caster sugar , plus extra to sprinkle",
            "1 orange",
            "50 g quality dark chocolate , (70%)"]
        method = """
            Preheat the oven to 190ºC/375ºF/gas 5.
            Grease a 20cm square baking tin and line with greaseproof paper.
            In a bowl, mix together the butter, flour, sugar and the finely grated zest of half the orange by rubbing the mixture between your thumbs and fingertips.
            Squash and pat into dough – don’t knead it – then push into the lined tin in a 1cm-thick layer. Prick all over with a fork, then bake for 20 minutes, or until lightly golden.
            Remove, sprinkle over a little extra sugar while it’s still warm, then leave to cool.
            Meanwhile, melt the chocolate in a heatproof bowl over a pan of gently simmering water, then remove.
            Cut the shortbread into 12 finger portions, then transfer to a wire cooling rack.
            Drizzle with the chocolate, then finely grate over the remaining orange zest. Cut up the orange, and serve on the side!
            """
        type = DishType.dessert
        image = UIImage(named: "ChocolateOrangeShortbread")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "Hazelnut madeleines with frangelico cream"
        ingredients = ["185 g unsalted butter",
            "60 ml double cream",
            "1 tablespoon runny honey",
            "4 large free-range eggs",
            "150 g caster sugar",
            "20 g demerara sugar",
            "185 g plain flour",
            "80 g ground hazelnuts",
            "1 heaped teaspoon baking powder",
            "400 g double cream",
            "60 g icing sugar",
            "1 vanilla pod",
            "75 ml Frangelico , or other hazelnut liqueur"]
        method = """
            Heat the butter and cream in a pan over a medium heat until the butter is browning. Take off the heat and stir in the honey, mixing until it’s cooled and barely warm to the touch. Set aside.
            Place the eggs and both sugars into the bowl of an electric mixer with a whisk attachment and whisk on a high speed until very light and fluffy – about 10 minutes.
            Add the browned butter and cream, whisk briefly, then fold in the dry mixture. Pop the batter in the fridge to rest for about 1 hour.
            Preheat the oven to 200°C/400°F/gas 6. Grease a 12-hole madeleine tray with butter and dust with flour.
            Fill each madeleine shell with 1 heaped tablespoon of the chilled batter, then bake in the oven for 8 minutes, or until golden.
            To make the Frangelico cream, split the vanilla pod in half lengthways and scrape out the seeds, either with a teaspoon or the back of your knife.
            Put the vanilla seeds in a bowl with the cream, icing sugar and Frangelico, then whisk until thick enough to form soft peaks.
            Spoon into a bowl and serve alongside the warm madeleines for dipping.
            """
        type = DishType.dessert
        image = UIImage(named: "HazelnutMadeleinesWithFrangelicoCream")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "Summer cordial"
        ingredients = ["600 g raspberries",
            "2 lemons",
            "250 g golden caster sugar"]
        method = """
            Place the raspberries in a medium saucepan over a medium heat with 300ml water.
            Use a speed peeler to strip the zest from the lemons into the pan. Bring to a gentle simmer, then cook for 10 to 15 minutes, stirring regularly, until the fruit has broken down. (Don’t let it boil.)
            Line a fine sieve with muslin over a large bowl (if you don’t have muslin, you can use a sheet of high-quality kitchen paper) and strain the mixture into a large bowl.
            Pour the liquid back into the pan, add the sugar and squeeze in the juice of both lemons.
            Turn the heat on to medium-low and stir regularly until all of the sugar has dissolved.
            Pour into a 1.2-litre sterilised bottle or jar and drink diluted with water, soda, cava or Prosecco.
            """
        type = DishType.drink
        image = UIImage(named: "SummerCordial")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        
        title = "English garden mocktail"
        ingredients = ["2 oranges",
            "1 lemon",
            "¼ of a cucumber",
            "1 handful of strawberries",
            "4 sprigs of mint",
            "1½ tablespoons balsamic vinegar",
            "1 tablespoon apple cider vinegar",
            "1 handful of ice cubes",
            "600 ml lemonade",
            "300 ml sparkling water"]
        method = """
            Halve one orange and squeeze the juice into a large jug.
            Cut the lemon, cucumber, strawberries and remaining orange into thick slices, adding to the jug as you go.
            Pick and finely slice the mint leaves and add to the jug with the vinegars, mint sprigs and a good handful of ice.
            Top up with the lemonade and sparkling water and give it a good stir.
            Leave to sit for 5 minutes, then pour into glasses and serve.
            """
        type = DishType.drink
        image = UIImage(named: "EnglishGardenMocktail")!
        
        recipes.append(Recipe.create(withTitle: title, ingredients: ingredients, method: method, type: type, image: image))
        return Profile.create(withName: "Test Name", recipes: recipes)
        
    }
}

/**
 * Policy Mappings
 * (sails.config.policies)
 *
 * Policies are simple functions which run **before** your controllers.
 * You can apply one or more policies to a given controller, or protect
 * its actions individually.
 *
 * Any policy file (e.g. `api/policies/authenticated.js`) can be accessed
 * below by its filename, minus the extension, (e.g. "authenticated")
 *
 * For more information on how policies work, see:
 * http://sailsjs.org/#!/documentation/concepts/Policies
 *
 * For more information on configuring policies, check out:
 * http://sailsjs.org/#!/documentation/reference/sails.config/sails.config.policies.html
 */

var lvl1 = ['localize', 'setUser']
var lvl2 = lvl1.concat(['isAuthenticated'])

 // var publicArray  = ['passport', 'localize']
 // var authArray    = ['localize', 'passport', 'isAuthenticated']
 // var walletArray  = ['localize', 'passport', 'isAuthenticated', 'wallet']

var passport = require('passport')

module.exports.policies = {

  /***************************************************************************
  *                                                                          *
  * Default policy for all controllers and actions (`true` allows public     *
  * access)                                                                  *
  *                                                                          *
  ***************************************************************************/

  // '*': publicArray,
  '*': lvl1,

  // AuthController: {
  //   // login: publicArray,
  // },

  DashboardController: {
    '*': ['isAuthenticated'],
  },
  //
  UserController: {
    create: true,
    '*': lvl2,
  },
  //
  OrderController: {
    '*': lvl2,
  },
  //
  HomeController: {
    // public: publicArray,
    private: lvl2,
  },
  //
  CleanController: {
    clean: lvl2.concat(['cardList'])
  },

  AuthController: {
    'login': ['noSessionAuth']
  },

  /***************************************************************************
  *                                                                          *
  * Here's an example of mapping some policies to run before a controller    *
  * and its actions                                                          *
  *                                                                          *
  ***************************************************************************/
	// RabbitController: {

		// Apply the `false` policy as the default for all of RabbitController's actions
		// (`false` prevents all access, which ensures that nothing bad happens to our rabbits)
		// '*': false,

		// For the action `nurture`, apply the 'isRabbitMother' policy
		// (this overrides `false` above)
		// nurture	: 'isRabbitMother',

		// Apply the `isNiceToAnimals` AND `hasRabbitFood` policies
		// before letting any users feed our rabbits
		// feed : ['isNiceToAnimals', 'hasRabbitFood']
	// }
};

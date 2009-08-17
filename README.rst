=======================
Overview
=======================

This project started as a Google Summer of Code project, sponsored by the Sunlight Foundation.
Project details are available `here <http://wiki.sunlightlabs.com/Get_Represented>`_ (the Sunlight Labs wiki).
Live versions of this application can be accessed at `getrep.sunlightlabs.net <http://getrep.sunlightlabs.net/>`_ and `myagenda.org <http://www.myagenda.org/>`_ .


About Get Represented
---------------------

We need to use the Internet to make it so that communicating to congress, 
whether you're an activist, lobbyist, advocacy group, or just John Q. Public, 
is easy and effective. It should aggregate ideas and allow people to publicly 
send messages to congress and allow for the public to read those messages and 
see what their neighbors are telling their representatives. Get Represented 
takes a look at the GetSatisfaction.com model and tries to apply it to Congress.

How it works
------------
* User registers with username, email, password, and address (optional openid)
* Congress members are assigned to user based on address/ congressional district
* User can post questions, ideas, problems, and praise for any one of their assigned members
* User can petition congress member to join site if they are not already registered
* Users can vote on any posted items by other users, and sort by popularity and activity
* Users can comment on any posted items
* Congress members can respond directly to user feedback
* ???
* Profit

Getting it Running
------------------
* Set up the project in your development environment and create a database.yml file in the config directory (make sure you have a working database)
* rake:migrate
* Run the custom rake tasks defined below (or simply run "rake db:update_all" to automate them all).
* Start your server, and register a new user
* To make a user an admin, run "rake db:set_admin[username]".

Custom Rake Tasks
-----------------
* db:update_members - This rake task will communicate with the Sunlight API and download all of the current Congress members and create accounts in the database.
* db:add_categories - This rake task simply adds the pre-populated list of categories into the list. They can be changed in the database.rake file if you want different categories.
* db:add_types - This will add the different posts types available. Currently, they are set at Questions, Ideas, Praise, Problems, and Petitions.
* db:update_all - This will combine the three above rake tasks, ideal for first-time setup.
* db:set_admin[username] - This will set the specified username to admin status. Warning! There is currently only one type of admin, and this is a superadmin. Optionally, if you wish to revoke admin status from a user (not from the online interface), you can run "rake db:set_admin[username,false]" and the admin status will be revoked. Note, there is no spaces in "[username,false]".

Licensing
---------

The Get Represented project is licensed under the `MIT license <http://www.opensource.org/licenses/mit-license.php>`_.

`Click here to read license <http://github.com/sunlightlabs/getrepresented/blob/master/LICENSE>`_.
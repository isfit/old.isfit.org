# Tabulous gives you an easy way to set up tabs for your Rails application.
#
#   1. Configure this file.
#   2. Add <%= tabs %> and <%= subtabs %> in your layout(s) wherever you want
#      your tabs to appear.
#   3. Add styles for these tabs in your stylesheets.
#   4. Profit!

Tabulous.setup do |config|

  #---------------------------
  #   HOW TO USE THE TABLES
  #---------------------------
  #
  # The following tables are just an array of arrays.  As such, you can put
  # any Ruby code into a cell.  For example, you could put "/foo/bar" in
  # a path cell or you could put "/foo" + "/bar".  You can even wrap up code
  # in a lambda to be executed later.  These will be executed in the context
  # of a Rails view meaning they will have access to view helpers.
  #
  # However, there is something special about the format of these tables.
  # Because it would be a pain for you to manually prettify the tables each
  # time you edit them, there is a special rake task that does this for
  # you: rake tabs:format.  However, for this prettifier to work properly
  # you have to follow some special rules:
  #
  #   * No comments are allowed between rows.
  #   * Comments are allowed to the right of rows, except for header rows.
  #   * The start of a table is signified by a [ all by itself on a line.
  #   * The end of a table is signified by a ] all by itself on a line.
  #   * And most importantly: commas that separate cells should be surrounded
  #     by spaces and commas that are within cells should not.  This gives the
  #     formatter an easy way to distinguish between cells without having
  #     to actually parse the Ruby.

  #----------
  #   TABS
  #----------
  #
  # This is where you define your tabs and subtabs.  The order that the tabs
  # appear in this list is the order they will appear in your views.  Any
  # subtabs defined will have the previous tab as their parent.
  #
  # TAB NAME
  #   must end in _tab or _subtab
  # DISPLAY TEXT
  #   the text the user sees on the tab
  # PATH
  #   the URL that gets sent to the server when the tab is clicked
  # VISIBLE
  #   whether to display the tab
  # ENABLED
  #   whether the tab is disabled (unclickable)

  config.tabs do
    [
      #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
      #    TAB NAME                           |    DISPLAY TEXT               |    PATH                                                               |    VISIBLE?    |    ENABLED?    #
      #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
      [    :articles_tab                      ,    'News'                     ,    root_path                                                          ,    false       ,    false       ],
      [    :isfit_media_links_tab             ,    'Isfit Media Links'        ,    isfit_media_links_path                                             ,    false       ,    false       ],
      [    :project_supports_tab              ,    'Project Supports'         ,    project_supports_path                                              ,    false       ,    false       ],
      [    :hosts_tab                         ,    'Hosts'                    ,    hosts_path                                                         ,    false       ,    false       ],
      [    :alumni_reservations_tab           ,    'Alumni Reservations'      ,    alumni_reservations_path                                           ,    false       ,    false       ],
      [    :pages_tab                         ,    'Pages'                    ,    pages_path                                                         ,    false       ,    false       ],
      [    :press_accreditations_tab          ,    'Press Accreditations'     ,    press_accreditations_path                                          ,    false       ,    false       ],
      [    :isfit_media_links_tab             ,    'Isfit Media Links'        ,    url_for(:controller => 'isfit_media_links', :action => 'index')    ,    false       ,    false       ],
      [    :press_releases_tab                ,    'Press Releases'           ,    press_releases_path                                                ,    false       ,    false       ],
      [    :workshops_tab                     ,    'Workshops'                ,    workshops_path                                                     ,    false       ,    false       ],
      [    :participants_tab                  ,    'Participants'             ,    participants_path                                                  ,    false       ,    false       ],
      [    :dialogue_participants_tab         ,    'Dialogue Participants'    ,    dialogue_participants_path                                         ,    false       ,    false       ],
      [    :articles_tab                      ,    t('tabs.articles.main')                     ,    root_path                                                          ,    true        ,    false        ],
      [    :articles_archive_subtab              ,    t('tabs.articles.archive')        ,    url_for(:controller => 'articles', :action => 'all')                                                          ,    true        ,    true        ],
      [    :articles_galleries_subtab         ,    t('tabs.articles.galleries')                ,    page_path(65)                                                          ,    true        ,    true        ],
      [    :positions_tab                     ,    t('tabs.positions.main')        ,   root_path, Language.to_s.eql?('no'), false],
      [    :positions_form_subtab             ,    t('tabs.positions.form')   ,   page_path(82), true, true],
      [    :positions_info_subtab             ,    t('tabs.positions.info')   ,   page_path(81), true, true],
      [    :theme_tab                         ,    t('tabs.theme.main')             ,    photos_path                                                        ,    true        ,    false        ],
      [    :theme_globaltrade_subtab          ,    t('tabs.theme.globaltrade')             ,    page_path(52)                                                        ,    false        ,    true        ],
      [    :theme_labour_subtab          ,    t('tabs.theme.labour')             ,    page_path(78)                                                        ,    true        ,    true        ],
      [    :theme_workshops_subtab            ,    t('tabs.theme.workshops')                ,    page_path(53)                                                        ,    false        ,    true        ],
      [    :theme_tradeyourideas_subtab       ,    t('tabs.theme.tradeyourideas')         ,    ideas_path                                                        ,    false        ,    true        ],
      [    :theme_themeblog_subtab            ,    t('tabs.theme.themeblog')               ,    page_path(66)                                                        ,    false        ,    false        ],
      [    :theme_map_subtab       ,    t('tabs.theme.map')          ,    '/world-map/'                                                        ,    false        ,    true        ],
      [    :theme_previousthemes_subtab       ,    t('tabs.theme.previousthemes')          ,    page_path(58)                                                        ,    true        ,    true        ],
      [    :about_tab                         ,    t('tabs.about.main')                    ,    photos_path                                                        ,    true        ,    false        ],
      [    :about_whatisisfit_subtab          ,    t('tabs.about.whatisisfit')                    ,    page_path(7)                                                        ,    true        ,    true        ],
      [    :about_dialoguegroups_subtab       ,    t('tabs.about.dialoguegroups')          ,    page_path(3)                                                        ,    true        ,    true        ],
      [    :about_conflictareas_subtab        ,    t('tabs.about.conflictareas')           ,    page_path(57)                                                        ,    false        ,    true        ],
      [    :about_studentpeaceprice_subtab    ,    t('tabs.about.studentpeaceprice')      ,    page_path(42)                                                        ,    true        ,    true        ],
      [    :about_walkofpeace_subtab          ,    t('tabs.about.walkofpeace')            ,    page_path(59)                                                        ,    true        ,    true        ],
      [    :about_partners_subtab                   ,    t('tabs.about.partners' )                     ,    page_path(69)                                                        ,    false        ,    true        ],
      [    :info_tab                          ,    t('tabs.info.main')                     ,    photos_path                                                        ,    true        ,    false        ],
      [    :info_participant_subtab           ,    t('tabs.info.participant')              ,    page_path(61)                                                        ,    true        ,    true        ],
      [    :info_volunteer_subtab             ,    t('tabs.info.volunteer')                ,    page_path(62)                                                     ,    false        ,    false        ],
      [    :info_press_subtab                 ,    t('tabs.info.press')                    ,    page_path(54)                                                        ,    false        ,    true        ],
      [    :info_donate_subtab                ,    t('tabs.info.donate' )                  ,    page_path(60)                                                        ,    true        ,    true        ],
      [    :info_contact_subtab               ,    t('tabs.info.contact')                  ,    page_path(27)                                                        ,    true        ,    true        ],
      [    :info_faq_subtab                   ,    t('tabs.info.faq' )                     ,    page_path(55)                                                        ,    false        ,    true        ],
      [    :info_hosts_subtab                   ,    t('tabs.info.host' )                     ,    hosts_path                                                        ,    false        ,    true        ],
      [    :info_movies_subtab                   ,    t('tabs.info.movies' )                     ,    page_path(76)                                                        ,    true        ,    true        ],
      [    :info_media_subtab                   ,    t('tabs.info.media' )                     ,    page_path(77)                                                        ,    true        ,    true        ],
      [    :blogs_tab                   ,    t('tabs.blogs.main' )                     ,    photos_path                                                        ,    false        ,    false        ],
      [    :blogs_theme_subtab                   ,    t('tabs.blogs.theme' )                     ,   Language.to_s == 'no' ? 'http://isfit.github.com/blog/' : 'http://isfit.github.com/blog/en.html'                                                         ,    true        ,    true        ],
      [    :blogs_festival_subtab                   ,    t('tabs.blogs.festival' )                     ,    Language.to_s == 'no' ? 'http://isfit2013.blogspot.com' : 'http://isfit2013eng.blogspot.com'                                                      ,    true        ,    true        ],
      [    :languages_tab                   ,    t('tabs.languages.main' )                     ,    photos_path                                                        ,    true        ,    false        ],
      [    :languages_norsk_subtab                   ,    'Norsk'                     ,    '?locale=no'                                                        ,    true        ,    true        ],
      [    :languages_english_subtab                   ,    'English'                     ,    '?locale=en'                                                        ,    true        ,    true        ],
      [    :events_tab                        ,    'Events'                   ,    events_path                                                        ,    false       ,    false       ],
      [    :events_program_subtab             ,    'Events'                   ,    photos_path                                                        ,    false       ,    false       ],
      [    :stats_tab             ,    'Stats'                   ,    stats_path                                                        ,    false       ,    true       ],
      [    :mailing_lists_tab     ,     t('tabs.mailing_lists')  ,    mailing_lists_path, false, false ],
      #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
      #    TAB NAME                           |    DISPLAY TEXT               |    PATH                                                               |    VISIBLE?    |    ENABLED?    #
      #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
    ]
  end




  #-------------
  #   ACTIONS
  #-------------
  #
  # This is where you hook up actions with tabs.  That way tabulous knows
  # which tab and subtab to mark active when an action is rendered.
  #
  # CONTROLLER
  #   the name of the controller
  # ACTION
  #   the name of the action, or :all_actions
  # TAB
  #   the name of the tab or subtab that is active when this action is rendered

  config.actions do
    [
      #--------------------------------------------------------------------------------------#
      #    CONTROLLER                |    ACTION          |    TAB                           #
      #--------------------------------------------------------------------------------------#
      [    :articles                 ,    :all_actions    ,    :articles_tab                 ],
      [    :marketing                ,    :all_actions    ,    :articles_tab                 ],
      [    :isfit_media_links        ,    :all_actions    ,    :isfit_media_links_tab        ],
      [    :project_supports         ,    :all_actions    ,    :project_supports_tab         ],
      [    :hosts                    ,    :all_actions    ,    :hosts_tab                    ],
      [    :alumni_reservations      ,    :all_actions    ,    :alumni_reservations_tab      ],
      [    :pages                    ,    :all_actions    ,    :pages_tab                    ],
      [    :press_accreditations     ,    :all_actions    ,    :press_accreditations_tab     ],
      [    :isfit_media_links        ,    :all_actions    ,    :isfit_media_links_tab        ],
      [    :press_releases           ,    :all_actions    ,    :press_releases_tab           ],
      [    :workshops                ,    :all_actions    ,    :workshops_tab                ],
      [    :participants             ,    :all_actions    ,    :participants_tab             ],
      [    :dialogue_participants    ,    :all_actions    ,    :dialogue_participants_tab    ],
      [    :chronicles               ,    :all_actions    ,    :chronicles_tab               ],
      [    :photos                   ,    :all_actions    ,    :photos_subtab                ],
      [    :positions                ,    :all_actions    ,    :info_volunteer_subtab        ],
      [    :donations                ,    :all_actions    ,    :info_donate_subtab           ],
      [    :ideas                    ,    :all_actions    ,    :info_donate_subtab           ],
      [    :stats                    ,    :all_actions    ,    :stats_tab                    ],
      [    :events                   ,    :all_actions    ,    :events_tab                   ],
      [    :mailing_lists            ,    :all_actions    ,    :mailing_lists_tab            ],
      #--------------------------------------------------------------------------------------#
      #    CONTROLLER                |    ACTION          |    TAB                           #
      #--------------------------------------------------------------------------------------#
    ]
  end

  #---------------------
  #   GENERAL OPTIONS
  #---------------------

  # By default, you cannot click on the active tab.
  config.active_tab_clickable = true

  # By default, the subtabs HTML element is not rendered if it is empty.
  config.always_render_subtabs = false

  # Tabulous expects every controller action to be associated with a tab.
  # When an action does not have an associated tab (or subtab), you can
  # instruct tabulous how to behave:
  config.when_action_has_no_tab = :raise_error      # the default behavior
  # config.when_action_has_no_tab = :do_not_render  # no tab navigation HTML will be generated
  # config.when_action_has_no_tab = :render         # the tab navigation HTML will be generated,
                                                    # but no tab or subtab will be active

  #--------------------
  #   MARKUP OPTIONS
  #--------------------

  # By default, div elements are used in the tab markup.  When html5 is
  # true, nav elements are used instead.
  config.html5 = true

  # This gives you control over what class the <ul> element that wraps the tabs
  # will have.  Good for interfacing with third-party code like Twitter
  # Bootstrap.
  config.tabs_ul_class = "nav nav-pills"

  # This gives you control over what class the <ul> element that wraps the subtabs
  # will have.  Good for interfacing with third-party code.
  # config.subtabs_ul_class = "nav"

  # Set this to true to have subtabs rendered in markup that Twitter Bootstrap
  # understands.  If this is set to true, you don't need to call subtabs in
  # your layout, just tabs.
  config.bootstrap_style_subtabs = true


  #-------------------
  #   STYLE OPTIONS
  #-------------------
  #
  # The markup that is generated has the following properties:
  #
  #   Tabs and subtabs that are selected have the class "active".
  #   Tabs and subtabs that are not selected have the class "inactive".
  #   Tabs that are disabled have the class "disabled"; otherwise, "enabled".
  #   Tabs that are not visible do not appear in the markup at all.
  #
  # These classes are provided to make it easier for you to create your
  # own CSS (and JavaScript) for the tabs.

  # Some styles will be generated for you to get you off to a good start.
  # Scaffolded styles are not meant to be used in production as they
  # generate invalid HTML markup.  They are merely meant to give you a
  # head start or an easy way to prototype quickly.  Set this to false if
  # you are using Twitter Bootstrap.
  # 
  config.css.scaffolding = false

  # You can tweak the colors of the generated CSS.
  #
  # config.css.background_color = '#ccc'
  # config.css.text_color = '#444'
  # config.css.active_tab_color = 'white'
  # config.css.hover_tab_color = '#ddd'
  # config.css.inactive_tab_color = '#aaa'
  # config.css.inactive_text_color = '#888'

end

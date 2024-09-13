::  prayers frontend
::
/-  *prayers
/+  rudder
::
^-  (page:rudder [prayers @t (list @t) (map)] [~ @t])
|_  [bowl:gall order:rudder =prayers @t avoid=(list @t) (map)]
++  argue
  |=  [head=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder [~ @t])
  ?~  body  ~
  =/  args=(map @t @t)
    (frisk:rudder q.u.body)
  ?~  what=(~(get by args) 'prayer')
    ~
  ?:  (lte (met 3 u.what) 1)
    'but thou, when thou prayest, enter into thy closet, and when thou hast shut thy door, pray to thy Father which is in secret; and thy Father which seeth in secret shall reward thee openly.'
  ?:  (gth (met 3 u.what) 1.024)
    'but when ye pray, use not vain repetitions, as the heathen do: for they think that they shall be heard for their much speaking.'
  [~ u.what]
::
++  final  ::  (alert:rudder (cat 3 '/' dap) build)
  |=  [done=? =brief:rudder]
  ?:  =('from your lips to God\'s ears...' brief)
    =+  r=(~(got by (frisk:rudder q:(need body.request))) 'prayer')
    (build ['prayer' r]~ `[done ?>(?=(@t brief) brief)])
  ((alert:rudder (cat 3 '/' dap) build) done brief)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  =/  title=tape
    ?:  &((gth now ~2023.12.24..18.00.00) (lth now ~2023.12.27))
      "good tidings of great joy"
    "prayers for the joyless and joyful alike"
  |^  [%page page]
  ::
  ++  style
    =;  s=@t
      %^  cat  3  s
      ?:  &((gth now ~2023.4.1) (lth now ~2023.4.2..06.00.00))
        'body{background-image:linear-gradient(345deg, #99eaea, #8fdb78, #a0a0e5, #7bdfdf);}'
      ?:  &((gth now ~2023.12.24..18.00.00) (lth now ~2023.12.27))
        'body{background-image:linear-gradient(345deg, lightgreen, green, red, orange);}'
      ''
    '''
    * { margin: 0; padding: 0; color: #fff0ff; font-family: sans-serif; }
    .status, .warn { margin: 1em; clear: both; }

    body {
      height: 100vh;
      width: 100vw;
      text-align: center;
      overflow-x: hidden;

      background-image: linear-gradient(345deg, #df7bdf, #847bde, #e5a0a0, #8199dc);
      background-size: 800% 800%;
      background-attachment: fixed;

      -webkit-animation: bg 160s ease infinite;
      -moz-animation: bg 160s ease infinite;
      animation: bg 160s ease infinite;
    }

    @-webkit-keyframes bg {
      0%{background-position:51% 0%}
      50%{background-position:50% 100%}
      100%{background-position:51% 0%}
    }
    @-moz-keyframes bg {
      0%{background-position:51% 0%}
      50%{background-position:50% 100%}
      100%{background-position:51% 0%}
    }
    @keyframes bg {
      0%{background-position:51% 0%}
      50%{background-position:50% 100%}
      100%{background-position:51% 0%}
    }

    h1 {
      font-weight: lighter;
      margin-top: 1em;
      font-style: italic;
    }

    form {
      margin: 2em auto 1em;
    }
    input, button {
      background-color: rgba(0,0,0,0.3);
      padding: 0.5em;
      width: 80vw;
      max-width: min(80vw, 500px);
      border-radius: 0.5em;
      border: 0.1em solid #fff0ff;
      font-size: 1.5em;
    }

    #listing {
      padding: 1em;
    }

    .prayer {
      margin-bottom: 2em;
      text-shadow: 1px 1px 3px rgb(0 0 0 / 15%);
      letter-spacing: 0.1px;
    }
    '''
  ::
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"{title}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style)}"
      ==
      ;body
        ;h1:"{title}"

        ;+  status

        ;+  ?:  pals-installed  :/""
            dependency-warning

        ;+  input
        ;+  listing
      ==
    ==
  ::
  ++  pals-installed  ~+
    .^(? %gu /(scot %p our)/pals/(scot %da now)/$)
  ::
  ++  mutuals  ~+
    .^((set ship) %gx /(scot %p our)/pals/(scot %da now)/mutuals/noun)
  ::
  ++  dependency-warning
    ^-  manx
    ;p.warn
      ; this app requires %pals for peer discovery.
      ;a(href "/apps/grid/perma/~paldev/pals/"):"install it from ~paldev/pals."
    ==
  ::
  ++  status
    ^-  manx
    ?~  msg  :/""
    ;p.status:"{(trip t.u.msg)}"
  ::
  ++  input
    ^-  manx
    =/  value=tape
      ?.  ?=([[%prayer @] *] arg)  ""
      (trip v.i.arg)
    ;form(method "post")
      ;input
        =type          "text"
        =name          "prayer"
        =required      ""
        =placeholder   prompt
        =autocomplete  "off"
        =value         value;
    ==
  ::
  ++  listing
    ^-  manx
    ;div#listing
      ;*  ?~  prayers  ;+  ;i:"it's been strangely quiet..."
          =/  n=@ud  0
          |-  ^-  marl
          ?:  (gte n 50)  ~
          ?:  (lth when.i.prayers (sub now ~d14))  ~
          ?:  %+  lien  avoid
              |=(=@t ?=(^ (find (trip t) (cass (trip what.i.prayers)))))
            ?~  t.prayers  ~
            $(prayers t.prayers)
          =*  w  when.i.prayers
          =.  w  (sub w (mod w ~s1))
          :-  ;div.prayer(title (scow %da w)):"{(trip what.i.prayers)}"
          ?~  t.prayers  ~
          $(prayers t.prayers, n +(n))
    ==
  ::
  ++  prompt
    =-  (snag (~(rad og eny) (lent -)) -)
    ^-  (list tape)
    :~  "what i really need today is..."
        "someone i know needs this help, it's..."
        "i want to feel divine love..."
    ==
  --
--

{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    vesktop
  ];
  xdg.configFile."vesktop/themes/midnight-catppuccin-mocha.css".text = ''
    /**
     * @name midnight (catppuccin mocha)
     * @description A dark, rounded discord theme. Based on catppuccin mocha theme (https://github.com/catppuccin/catppuccin).
     * @author refact0r
     * @version 1.6.2
     * @invite nz87hXyvcy
     * @website https://github.com/refact0r/midnight-discord
     * @source https://github.com/refact0r/midnight-discord/blob/master/flavors/midnight-catppuccin-mocha.theme.css
     * @authorId 508863359777505290
     * @authorLink https://www.refact0r.dev
    */

    /* IMPORTANT: make sure to enable dark mode in discord settings for the theme to apply properly!!! */

    @import url('https://refact0r.github.io/midnight-discord/midnight.css');

    /* customize things here */
    :root {
    	/* font, change to 'gg sans' for default discord font*/
    	--font: 'figtree';

    	/* top left corner text */
    	--corner-text: 'Catppuccin';

    	/* color of status indicators and window controls */
    	--online-indicator: #a6e3a1; /* change to #23a55a for default green */
    	--dnd-indicator: #f38ba8; /* change to #f13f43 for default red */
    	--idle-indicator: #f9e2af; /* change to #f0b232 for default yellow */
    	--streaming-indicator: #cba6f7; /* change to #593695 for default purple */

    	/* accent colors */
    	--accent-1: hsl(267, 84%, 81%); /* links */
    	--accent-2: hsl(267, 84%, 81%); /* general unread/mention elements */
    	--accent-3: hsl(267, 84%, 81%); /* accent buttons */
    	--accent-4: hsl(267, 70%, 73%); /* accent buttons when hovered */
    	--accent-5: hsl(267, 55%, 65%); /* accent buttons when clicked */
    	--mention: hsla(267, 70%, 71%, 0.1); /* mentions & mention messages */
    	--mention-hover: hsla(267, 70%, 71%, 0.05); /* mentions & mention messages when hovered */

    	/* text colors */
    	--text-0: var(--bg-4); /* text on colored elements */
    	--text-1: hsl(220, 40%, 95%); /* bright text on colored elements */
    	--text-2: hsl(226, 64%, 88%); /* headings and important text */
    	--text-3: hsl(228, 24%, 72%); /* normal text */
    	--text-4: hsl(230, 13%, 55%); /* icon buttons and channels */
    	--text-5: hsl(233, 12%, 39%); /* muted channels/chats and timestamps */

    	/* background and dark colors */
    	--bg-1: hsl(234, 13%, 31%); /* dark buttons when clicked */
    	--bg-2: hsl(237, 16%, 23%); /* dark buttons */
    	--bg-3: hsl(240, 21%, 12%); /* spacing, secondary elements */
    	--bg-4: hsl(240, 21%, 15%); /* main background color */
    	--hover: hsla(237, 18%, 53%, 0.1); /* channels and buttons when hovered */
    	--active: hsla(235, 15%, 53%, 0.2); /* channels and buttons when clicked or selected */
    	--message-hover: hsla(240, 0%, 0%, 0.1); /* messages when hovered */

    	/* amount of spacing and padding */
    	--spacing: 12px;

    	/* animations */
    	/* ALL ANIMATIONS CAN BE DISABLED WITH REDUCED MOTION IN DISCORD SETTINGS */
    	--list-item-transition: 0.2s ease; /* channels/members/settings hover transition */
    	--unread-bar-transition: 0.2s ease; /* unread bar moving into view transition */
    	--moon-spin-transition: 0.4s ease; /* moon icon spin */
    	--icon-spin-transition: 1s ease; /* round icon button spin (settings, emoji, etc.) */

    	/* corner roundness (border-radius) */
    	--roundness-xl: 22px; /* roundness of big panel outer corners */
    	--roundness-l: 20px; /* popout panels */
    	--roundness-m: 16px; /* smaller panels, images, embeds */
    	--roundness-s: 12px; /* members, settings inputs */
    	--roundness-xs: 10px; /* channels, buttons */
    	--roundness-xxs: 8px; /* searchbar, small elements */

    	/* direct messages moon icon */
    	/* change to block to show, none to hide */
    	--discord-icon: none; /* discord icon */
    	--moon-icon: none; /* moon icon */
    	--moon-icon-url: none; /* custom icon url */
    	--moon-icon-size: auto;

    	/* filter uncolorable elements to fit theme */
    	/* (just set to none, they're too much work to configure) */
    	--login-bg-filter: none; /* login background artwork */
    	--green-to-accent-3-filter: none; /* add friend page explore icon */
    	--blurple-to-accent-3-filter: none; /* add friend page school icon */
    }

    /* catppuccin icon */
    .childWrapper_f90abb:has(> svg:not(.favoriteIcon_dcc7a4)) {
    	background: url('https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png');
    	background-color: transparent !important;
    	background-size: cover;
    }
    .container_b2ca13 /* user panel button strikethroughs */,
    .numberBadge_df8943  /* unread number badge */,
    .toolbar_e44302 /* toolbar button strikethroughs */ {
    	--status-danger: #e34973;
    	/* --status-danger: var(--accent-2); */
    }
  '';
}

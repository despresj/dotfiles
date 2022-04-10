"use strict";
var __assign = (this && this.__assign) || Object.assign || function(t) {
    for (var s, i = 1, n = arguments.length; i < n; i++) {
        s = arguments[i];
        for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
            t[p] = s[p];
    }
    return t;
};
exports.__esModule = true;
var path = require("path");
var vscode_theme_generator_1 = require("vscode-theme-generator");
var colors = {
    red: '#DA6771',
    redLight: '#e5949b',
    green: '#4EB071',
    greenDim: '#275839',
    yellow: '#fff099',
    blue: '#399EF4',
    blueLight: '#9fcff9',
    pink: '#B168DF',
    teal: '#21C5C7',
    grey: '#535a6b'
};
var colorSet = {
    base: {
        background: '#181e29',
        foreground: '#efefef',
        color1: colors.blue,
        color2: colors.red,
        color3: colors.green,
        color4: colors.yellow
    },
    syntax: {
        identifier: colors.blueLight,
        string: colors.red,
        number: colors.redLight,
        keyword: colors.blue,
        boolean: colors.blue,
        "function": colors.teal,
        functionCall: colors.yellow,
        storage: colors.blue,
        comment: colors.grey,
        "class": colors.teal,
        classMember: colors.teal,
        type: colors.green,
        cssClass: colors.blue,
        cssId: colors.red,
        cssTag: colors.teal,
        markdownQuote: '#c0c0c0'
    },
    ui: {
        cursor: '#ffffff',
        guide: '#263040',
        invisibles: '#263040',
        rangeHighlight: '#263040',
        // Bright red 50% opacity
        findMatchHighlight: '#cb606080',
        // Brighter red 50% opacity
        currentFindMatchHighlight: '#ff777780',
        selection: '#153958',
        // Blue 50% opacity
        selectionHighlight: '#2b74b380',
        // White with ~10% opacity
        wordHighlight: '#ffffff18',
        wordHighlightStrong: '#ffffff18',
        activeLinkForeground: colors.blue
    },
    terminal: {
        black: '#666666',
        red: colors.red,
        green: colors.green,
        yellow: colors.yellow,
        blue: colors.blue,
        magenta: colors.pink,
        cyan: colors.teal,
        white: '#efefef',
        brightBlack: '#666666',
        brightRed: colors.red,
        brightGreen: colors.green,
        brightYellow: colors.yellow,
        brightBlue: colors.blue,
        brightMagenta: colors.pink,
        brightCyan: colors.teal,
        brightWhite: '#efefef'
    },
    overrides: {
        "diffEditor.insertedTextBackground": "#182818",
        "diffEditor.removedTextBackground": "#261616",
        "editorGutter.modifiedBackground": "#4EB071",
        "editorGutter.addedBackground": "#399EF4",
        "editorGutter.deletedBackground": "#DA6771",
        "gitDecoration.modifiedResourceForeground": "#4EB071",
        "gitDecoration.deletedResourceForeground": "#DA6771",
        "gitDecoration.untrackedResourceForeground": "#399EF4",
        "gitDecoration.conflictingResourceForeground": "#fff099",
        "gitDecoration.ignoredResourceForeground": "#535a6b",
        "editorError.foreground": "#DA6771",
        "editorIndentGuide.activeBackground": "#535a6b"
    }
};
vscode_theme_generator_1.generateTheme('Sapphire', colorSet, path.join(__dirname, 'theme.json'));
var brightColorSet = {
    base: __assign({}, colorSet.base, { background: '#242d3d' }),
    syntax: __assign({}, colorSet.syntax, { comment: '#fff6' }),
    ui: __assign({}, colorSet.ui),
    terminal: __assign({}, colorSet.terminal),
    overrides: __assign({}, colorSet.overrides, { 'diffEditor.insertedTextBackground': '#0f02', 'diffEditor.removedTextBackground': '#f003', 'diffEditor.insertedTextBorder': '#0004', 'diffEditor.removedTextBorder': '#0004', 'editor.background': '#2a3447', 'editor.selectionBackground': '#fff3', 'tab.activeBackground': '#3a4966', 'tab.inactiveBackground': '#2d384d' })
};
vscode_theme_generator_1.generateTheme('Sapphire (Bright)', brightColorSet, path.join(__dirname, 'theme-bright.json'));
colorSet.base.background = '#080d14';
vscode_theme_generator_1.generateTheme('Sapphire (Dim)', colorSet, path.join(__dirname, 'theme-dim.json'));

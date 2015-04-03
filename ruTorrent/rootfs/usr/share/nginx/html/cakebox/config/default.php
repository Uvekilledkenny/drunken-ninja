<?php

/*
  General configuration of Cakebox
*/
$app["cakebox.root"] = "/rtorrent/downloads"; // Root directory Cakebox have to scan
$app["cakebox.access"] = "/access/"; // Alias used in web server for direct access
$app["cakebox.language"] = "fr"; //Language of Cakebox. Could be : fr, en

/*
  Directory settings
*/
$app["directory.ignoreDotFiles"] = false;
$app["directory.ignore"] = "//"; // Regex for files exclusion. For exemple : "/(\.nfo|\.test)$/"

/*
  Web player settings
*/
$app["player.default_type"] = "html5"; // html5 or divx or vlc
$app["player.auto_play"] = "false";

/*
  Betaseries account
  NB: Ask API key here http://www.betaseries.com/api/
*/
$app["bs.login"] = "";
$app["bs.passwd"] = "";
$app["bs.apikey"] = "";

$app["rights.canPlayMedia"] = true;
$app["rights.canDownloadFile"] = true;
$app["rights.canArchiveDirectory"] = true;
$app["rights.canDelete"] = true;

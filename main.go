package main

import (
	"github.com/pdecat/steampipe-plugin-azure/azure"

	"github.com/turbot/steampipe-plugin-sdk/v5/plugin"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		PluginFunc: azure.Plugin})
}

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppInsightsClient = void 0;
const appInsights = require("applicationinsights");
const utility_1 = require("./utility");
class AppInsightsClient {
    static sendEvent(eventName, properties, measurements) {
        if (this.EnableTelemetry) {
            this._client.trackEvent({ name: eventName, properties, measurements });
        }
    }
}
exports.AppInsightsClient = AppInsightsClient;
AppInsightsClient.EnableTelemetry = utility_1.Utility.getConfiguration().get("enableTelemetry");
AppInsightsClient._config = appInsights.setup("d4c27ff4-02a1-41ed-bb90-2816cd675ab8");
AppInsightsClient._client = appInsights.defaultClient;
//# sourceMappingURL=appInsightsClient.js.map
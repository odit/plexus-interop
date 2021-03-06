/**
 * Copyright 2017 Plexus Interop Deutsche Bank AG
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { CcyPairRateViewerClientBuilder, CcyPairRateViewerClient } from "./gen/CcyPairRateViewerGeneratedClient";
import { WebSocketConnectionFactory } from "@plexus-interop/websocket-transport";

// Read launch arguments, provided by Electron Launcher
declare var window: any;
const electron = window.require("electron")
const remote = electron.remote;
const webSocketUrl = remote.getCurrentWindow().plexusBrokerWsUrl;
const instanceId = remote.getCurrentWindow().plexusAppInstanceId;

new CcyPairRateViewerClientBuilder()
    // App's ID and Instance ID received from Launcher
    .withClientDetails({
        applicationId: "CcyPairRateViewer",
        applicationInstanceId: instanceId
    })
    // Pass Transport to be used for connecting to Broker
    .withTransportConnectionProvider(() => new WebSocketConnectionFactory(new WebSocket(webSocketUrl)).connect())
    .connect()
    .then((rateViewerClient: CcyPairRateViewerClient) => {
        // Client connected, we can use generated Proxy Service to perform invocation
        rateViewerClient.getCcyPairRateServiceProxy()
            .getRate({ccyPairName: "EURUSD"})
            .then(rateResponse => {
                document.body.innerText = `Received rate ${rateResponse.ccyPairName}-${rateResponse.rate}`;
            })
            .catch(e => console.log("Failed to receive rate", e))
    });

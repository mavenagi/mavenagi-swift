# Reference
## Actions
<details><summary><code>client.actions.<a href="/Sources/Resources/Actions/ActionsClient.swift">search</a>(request: ActionsSearchRequest, requestOptions: RequestOptions?) -> ActionsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.actions.search(request: ActionsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ActionsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.actions.<a href="/Sources/Resources/Actions/ActionsClient.swift">createOrUpdate</a>(request: ActionRequest, requestOptions: RequestOptions?) -> ActionResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update an action or create it if it doesn't exist
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.actions.createOrUpdate(request: ActionRequest(
        actionId: EntityIdBase(
            referenceId: "get-balance"
        ),
        name: "Get the user's balance",
        description: "This action calls an API to get the user's current balance.",
        userInteractionRequired: False,
        userFormParameters: [],
        precondition: Precondition.group(
            .init(
                operator: .and,
                preconditions: [
                    Precondition.user(
                        .init(
                            key: "userKey"
                        )
                    ),
                    Precondition.user(
                        .init(
                            key: "userKey2"
                        )
                    )
                ]
            )
        ),
        language: "en"
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ActionRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.actions.<a href="/Sources/Resources/Actions/ActionsClient.swift">get</a>(actionReferenceId: String, appId: String?, requestOptions: RequestOptions?) -> ActionResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an action by its supplied ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.actions.get(
        actionReferenceId: "get-balance",
        request: .init(actionReferenceId: "get-balance")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**actionReferenceId:** `String` — The reference ID of the action to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the action to get. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.actions.<a href="/Sources/Resources/Actions/ActionsClient.swift">patch</a>(actionReferenceId: String, request: Requests.ActionPatchRequest, requestOptions: RequestOptions?) -> ActionResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable action fields

The `appId` field can be provided to update an action owned by a different app. 
All other fields will overwrite the existing value on the action only if provided.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.actions.patch(
        actionReferenceId: "get-balance",
        request: .init(
            actionReferenceId: "get-balance",
            instructions: "Use this action when the user asks about their account balance or remaining credits.",
            llmInclusionStatus: .whenRelevant,
            segmentId: EntityId(
                referenceId: "premium-users",
                appId: "my-billing-system",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            )
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**actionReferenceId:** `String` — The reference ID of the action to patch.
    
</dd>
</dl>

<dl>
<dd>

**request:** `Requests.ActionPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.actions.<a href="/Sources/Resources/Actions/ActionsClient.swift">delete</a>(actionReferenceId: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Delete an action
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.actions.delete(actionReferenceId: "get-balance")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**actionReferenceId:** `String` — The reference ID of the action to unregister. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Agents
<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">search</a>(request: AgentsSearchRequest, requestOptions: RequestOptions?) -> AgentsSearchResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search for agents across all organizations.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.search(request: AgentsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">list</a>(organizationReferenceId: String, requestOptions: RequestOptions?) -> [Agent]</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Lists all agents for an organization
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.list(organizationReferenceId: "organizationReferenceId")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">create</a>(organizationReferenceId: String, agentReferenceId: String, request: CreateAgentRequest, requestOptions: RequestOptions?) -> Agent</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Create a new agent

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.create(
        organizationReferenceId: "organizationReferenceId",
        agentReferenceId: "agentReferenceId",
        request: CreateAgentRequest(
            name: "name",
            environment: .demo
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**agentReferenceId:** `String` — The ID of the agent.
    
</dd>
</dl>

<dl>
<dd>

**request:** `CreateAgentRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">get</a>(organizationReferenceId: String, agentReferenceId: String, requestOptions: RequestOptions?) -> Agent</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an agent
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.get(
        organizationReferenceId: "organizationReferenceId",
        agentReferenceId: "agentReferenceId"
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**agentReferenceId:** `String` — The ID of the agent.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">patch</a>(organizationReferenceId: String, agentReferenceId: String, request: Requests.AgentPatchRequest, requestOptions: RequestOptions?) -> Agent</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable agent fields 
All fields will overwrite the existing value on the agent only if provided.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.patch(
        organizationReferenceId: "organizationReferenceId",
        agentReferenceId: "agentReferenceId",
        request: .init(
            organizationReferenceId: "organizationReferenceId",
            agentReferenceId: "agentReferenceId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**agentReferenceId:** `String` — The ID of the agent.
    
</dd>
</dl>

<dl>
<dd>

**request:** `Requests.AgentPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.agents.<a href="/Sources/Resources/Agents/AgentsClient.swift">delete</a>(organizationReferenceId: String, agentReferenceId: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Delete an agent.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.agents.delete(
        organizationReferenceId: "organizationReferenceId",
        agentReferenceId: "agentReferenceId"
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**agentReferenceId:** `String` — The ID of the agent.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Analytics
<details><summary><code>client.analytics.<a href="/Sources/Resources/Analytics/AnalyticsClient.swift">getConversationTable</a>(request: ConversationTableRequest, requestOptions: RequestOptions?) -> ConversationTableResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieves structured conversation data formatted as a table, allowing users to group, filter, and define specific metrics to display as columns.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.analytics.getConversationTable(request: ConversationTableRequest(
        conversationFilter: ConversationFilter(
            languages: [
                "en",
                "es"
            ]
        ),
        timeGrouping: .day,
        fieldGroupings: [
            ConversationGroupBy(
                field: .category
            )
        ],
        columnDefinitions: [
            ConversationColumnDefinition(
                header: "count",
                metric: ConversationMetric.count(
                    .init(

                    )
                )
            ),
            ConversationColumnDefinition(
                header: "avg_first_response_time",
                metric: ConversationMetric.average(
                    .init(
                        targetField: .firstResponseTime
                    )
                )
            ),
            ConversationColumnDefinition(
                header: "percentile_handle_time",
                metric: ConversationMetric.percentile(
                    .init(
                        targetField: .handleTime,
                        percentile: 25
                    )
                )
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationTableRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.analytics.<a href="/Sources/Resources/Analytics/AnalyticsClient.swift">getConversationChart</a>(request: ConversationChartRequest, requestOptions: RequestOptions?) -> ChartResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Fetches conversation data visualized in a chart format. Supported chart types include pie chart, date histogram, and stacked bar charts.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.analytics.getConversationChart(request: ConversationChartRequest.pieChart(
        .init(
            conversationFilter: ConversationFilter(
                languages: [
                    "en",
                    "es"
                ]
            ),
            groupBy: ConversationGroupBy(
                field: .category
            ),
            metric: ConversationMetric.count(
                .init(

                )
            )
        )
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationChartRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.analytics.<a href="/Sources/Resources/Analytics/AnalyticsClient.swift">exportConversationTable</a>(request: ConversationTableRequest, requestOptions: RequestOptions?) -> Data</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Export the conversation analytics table to a CSV file.

This outputs the current table view defined by the request. For most programmatic use cases, prefer `getConversationTable` and format client-side. The CSV format may change and should not be relied upon by code consumers. A maximum of 10,000 rows can be exported at a time.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.analytics.exportConversationTable(request: ConversationTableRequest(
        fieldGroupings: [
            ConversationGroupBy(
                field: .category
            ),
            ConversationGroupBy(
                field: .category
            )
        ],
        columnDefinitions: [
            ConversationColumnDefinition(
                metric: ConversationMetric.count(
                    .init(

                    )
                ),
                header: "header"
            ),
            ConversationColumnDefinition(
                metric: ConversationMetric.count(
                    .init(

                    )
                ),
                header: "header"
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationTableRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.analytics.<a href="/Sources/Resources/Analytics/AnalyticsClient.swift">getFeedbackTable</a>(request: FeedbackTableRequest, requestOptions: RequestOptions?) -> FeedbackTableResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieves structured feedback data formatted as a table, allowing users to group, filter,  and define specific metrics to display as columns.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.analytics.getFeedbackTable(request: FeedbackTableRequest(
        feedbackFilter: FeedbackFilter(
            types: [
                .thumbsUp,
                .insert
            ]
        ),
        fieldGroupings: [
            FeedbackGroupBy(
                field: .createdBy
            )
        ],
        columnDefinitions: [
            FeedbackColumnDefinition(
                header: "feedback_count",
                metric: FeedbackMetric.count(
                    .init(

                    )
                )
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `FeedbackTableRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.analytics.<a href="/Sources/Resources/Analytics/AnalyticsClient.swift">getAgentUserTable</a>(request: AgentUserTableRequest, requestOptions: RequestOptions?) -> AgentUserTableResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieves structured agent user data formatted as a table, allowing users to group, filter,  and define specific metrics to display as columns.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.analytics.getAgentUserTable(request: AgentUserTableRequest(
        agentUserFilter: AgentUserFilter(
            search: "john"
        ),
        columnDefinitions: [
            AgentUserColumnDefinition(
                header: "user_count",
                metric: AgentUserMetric.count(
                    .init(

                    )
                )
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentUserTableRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## AppSettings
<details><summary><code>client.appSettings.<a href="/Sources/Resources/AppSettings/AppSettingsClient.swift">search</a>(index: String, requestOptions: RequestOptions?) -> SearchAppSettingsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search for app settings which have the `$index` key set to the provided value.

You can set the `$index` key using the Update app settings API.

<Warning>This API currently requires an organization ID and agent ID for any agent which is installed on the app. This requirement will be removed in a future update.</Warning>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.appSettings.search(request: .init(index: "index"))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**index:** `String` — Will return all settings which have the `$index` key set to the provided value.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.appSettings.<a href="/Sources/Resources/AppSettings/AppSettingsClient.swift">get</a>(requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get app settings set during installation
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.appSettings.get()
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.appSettings.<a href="/Sources/Resources/AppSettings/AppSettingsClient.swift">update</a>(request: [String: JSONValue], requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update app settings. Performs a merge of the provided settings with the existing app settings.

- If a new key is provided, it will be added to the app settings.
- If an existing key is provided, it will be updated.
- No keys will be removed.

Note that if an array value is provided it will fully replace an existing value as arrays cannot be merged.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.appSettings.update(request: [
        "string": .object([
            "key": .string("value")
        ])
    ])
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `[String: JSONValue]` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Assets
<details><summary><code>client.assets.<a href="/Sources/Resources/Assets/AssetsClient.swift">initiateUpload</a>(request: InitiateAssetUploadRequest, requestOptions: RequestOptions?) -> InitiateAssetUploadResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Initiate an upload. 
Returns a pre-signed URL for direct file upload and an asset ID for subsequent operations.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.assets.initiateUpload(request: InitiateAssetUploadRequest(
        type: "type"
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `InitiateAssetUploadRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.assets.<a href="/Sources/Resources/Assets/AssetsClient.swift">commitUpload</a>(assetReferenceId: String, request: CommitAssetUploadRequest, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Commit an upload after successful file transfer.
Updates the asset status and makes it available for use.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.assets.commitUpload(
        assetReferenceId: "assetReferenceId",
        request: CommitAssetUploadRequest(

        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**assetReferenceId:** `String` — The reference ID of the asset to commit (provided by the initiate call). All other entity ID fields are inferred from the API request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `CommitAssetUploadRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Conversation
<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">initialize</a>(request: ConversationRequest, requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Initialize a new conversation. 
Only required if the ask request wishes to supply conversation level data or when syncing to external systems.

Conversations can not be modified using this API. If the conversation already exists then the existing conversation will be returned.

After initialization,
- metadata can be changed using the `updateConversationMetadata` API.
- messages can be added to the conversation with the `appendNewMessages` or `ask` APIs.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.initialize(request: ConversationRequest(
        conversationId: EntityIdBase(
            referenceId: "x"
        ),
        messages: [
            ConversationMessageRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "x"
                ),
                userId: EntityIdBase(
                    referenceId: "x"
                ),
                text: "text",
                userMessageType: .user
            ),
            ConversationMessageRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "x"
                ),
                userId: EntityIdBase(
                    referenceId: "x"
                ),
                text: "text",
                userMessageType: .user
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">patch</a>(conversationId: String, request: ConversationPatchRequest, requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable conversation fields. 

The `appId` field can be provided to update a conversation owned by a different app. 
All other fields will overwrite the existing value on the conversation only if provided.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.patch(
        conversationId: "conversation-0",
        request: ConversationPatchRequest(
            llmEnabled: True
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to patch
    
</dd>
</dl>

<dl>
<dd>

**request:** `ConversationPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">get</a>(conversationId: String, appId: String?, translationLanguage: String?, requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get a conversation
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.get(
        conversationId: "conversationId",
        request: .init(conversationId: "conversationId")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to get
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the conversation to get. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**translationLanguage:** `String?` — The language to translate the conversation analysis into
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">delete</a>(conversationId: String, appId: String?, reason: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Wipes a conversation of all user data. 
The conversation ID will still exist and non-user specific data will still be retained. 
Attempts to modify or add messages to the conversation will throw an error. 

Simulation conversations will no longer be visible in search results nor metrics. 
Non-simulation conversations will remain visible - they can not be fully removed from the system.

<Warning>This is a destructive operation and cannot be undone. <br/><br/>
The exact fields cleared include: the conversation subject, userRequest, agentResponse. 
As well as the text response, followup questions, and backend LLM prompt of all messages.</Warning>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.delete(
        conversationId: "conversation-0",
        request: .init(
            conversationId: "conversation-0",
            reason: "GDPR deletion request 1234."
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to delete
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the conversation to delete. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**reason:** `String` — The reason for deleting the conversation. This message will replace all user messages in the conversation.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">appendNewMessages</a>(conversationId: String, request: [ConversationMessageRequest], requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Append messages to an existing conversation. The conversation must be initialized first. If a message with the same ID already exists, it will be ignored. Messages do not allow modification.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.appendNewMessages(
        conversationId: "conversationId",
        request: [
            ConversationMessageRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "x"
                ),
                userId: EntityIdBase(
                    referenceId: "x"
                ),
                text: "text",
                userMessageType: .user
            ),
            ConversationMessageRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "x"
                ),
                userId: EntityIdBase(
                    referenceId: "x"
                ),
                text: "text",
                userMessageType: .user
            )
        ]
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to append messages to
    
</dd>
</dl>

<dl>
<dd>

**request:** `[ConversationMessageRequest]` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">ask</a>(conversationId: String, request: AskRequest, requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an answer from Maven for a given user question. If the user question or its answer already exists, 
they will be reused and will not be updated. Messages do not allow modification once generated. 

Concurrency Behavior:
- If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
- The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.

Known Limitation:
- The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.ask(
        conversationId: "conversation-0",
        request: AskRequest(
            conversationMessageId: EntityIdBase(
                referenceId: "message-0"
            ),
            userId: EntityIdBase(
                referenceId: "user-0"
            ),
            text: "How do I reset my password?",
            attachments: [
                AttachmentRequest(
                    type: "image/png",
                    content: "iVBORw0KGgo..."
                )
            ],
            transientData: [
                "userToken": "abcdef123", 
                "queryApiKey": "foobar456"
            ],
            timezone: "America/New_York"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of a new or existing conversation to use as context for the question
    
</dd>
</dl>

<dl>
<dd>

**request:** `AskRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">askStream</a>(conversationId: String, request: AskRequest, requestOptions: RequestOptions?) -> JSONValue</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an answer from Maven for a given user question with a streaming response. The response will be sent as a stream of events. 
The text portions of stream responses should be concatenated to form the full response text. 
Action and metadata events should overwrite past data and do not need concatenation.

If the user question or its answer already exists, they will be reused and will not be updated. 
Messages do not allow modification once generated.
        
Concurrency Behavior:
- If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
- The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.

Known Limitation:
- The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.askStream(
        conversationId: "conversation-0",
        request: AskRequest(
            conversationMessageId: EntityIdBase(
                referenceId: "message-0"
            ),
            userId: EntityIdBase(
                referenceId: "user-0"
            ),
            text: "How do I reset my password?",
            attachments: [
                AttachmentRequest(
                    type: "image/png",
                    content: "iVBORw0KGgo..."
                )
            ],
            transientData: [
                "userToken": "abcdef123", 
                "queryApiKey": "foobar456"
            ],
            timezone: "America/New_York"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of a new or existing conversation to use as context for the question
    
</dd>
</dl>

<dl>
<dd>

**request:** `AskRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">askObjectStream</a>(conversationId: String, request: AskObjectRequest, requestOptions: RequestOptions?) -> JSONValue</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Generate a structured object response based on a provided schema and user prompt with a streaming response. 
The response will be sent as a stream of events containing text, start, and end events.
The text portions of stream responses should be concatenated to form the full response text.

If the user question and object response already exist, they will be reused and not updated.

Concurrency Behavior:
- If another API call is made for the same user question while a response is mid-stream, partial answers may be returned.
- The second caller will receive a truncated or partial response depending on where the first stream is in its processing. The first caller's stream will remain unaffected and continue delivering the full response.

Known Limitations:
- Schema enforcement is best-effort and may not guarantee exact conformity.
- The API does not currently expose metadata indicating whether a response or message is incomplete. This will be addressed in a future update.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.askObjectStream(
        conversationId: "conversationId",
        request: AskObjectRequest(
            schema: "schema",
            conversationMessageId: EntityIdBase(
                referenceId: "x"
            ),
            userId: EntityIdBase(
                referenceId: "x"
            ),
            text: "text"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of a new or existing conversation to use as context for the object generation request
    
</dd>
</dl>

<dl>
<dd>

**request:** `AskObjectRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">categorize</a>(conversationId: String, requestOptions: RequestOptions?) -> CategorizationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Uses an LLM flow to categorize the conversation. Experimental.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.categorize(conversationId: "conversationId")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to categorize
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">createFeedback</a>(request: FeedbackRequest, requestOptions: RequestOptions?) -> Feedback</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update feedback or create it if it doesn't exist
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.createFeedback(request: FeedbackRequest(
        feedbackId: EntityIdBase(
            referenceId: "feedback-0"
        ),
        userId: EntityIdBase(
            referenceId: "user-0"
        ),
        conversationId: EntityIdBase(
            referenceId: "conversation-0"
        ),
        conversationMessageId: EntityIdBase(
            referenceId: "message-1"
        ),
        type: .thumbsUp,
        text: "Great answer!"
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `FeedbackRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">submitActionForm</a>(conversationId: String, request: SubmitActionFormRequest, requestOptions: RequestOptions?) -> ConversationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Submit a filled out action form. 
Action forms can not be submitted more than once, attempting to do so will result in an error.

Additionally, form submission is only allowed when the form is the last message in the conversation. 
Forms should be disabled in surface UI if a conversation continues and they remain unsubmitted.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.submitActionForm(
        conversationId: "conversationId",
        request: SubmitActionFormRequest(
            actionFormId: "actionFormId",
            parameters: [
                "parameters": ActionFormRequestParamValue.json(
                    .object([
                        "key": .string("value")
                    ])
                )
            ]
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of a conversation the form being submitted belongs to
    
</dd>
</dl>

<dl>
<dd>

**request:** `SubmitActionFormRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">addConversationMetadata</a>(conversationId: String, request: [String: String], requestOptions: RequestOptions?) -> [String: String]</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Replaced by `updateConversationMetadata`. 

Adds metadata to an existing conversation. If a metadata field already exists, it will be overwritten.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.addConversationMetadata(
        conversationId: "conversationId",
        request: [
            "string": "string"
        ]
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of a conversation the metadata being added belongs to
    
</dd>
</dl>

<dl>
<dd>

**request:** `[String: String]` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">updateConversationMetadata</a>(conversationId: String, request: UpdateMetadataRequest, requestOptions: RequestOptions?) -> ConversationMetadata</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update metadata supplied by the calling application for an existing conversation. 
Does not modify metadata saved by other apps.

If a metadata field already exists for the calling app, it will be overwritten. 
If it does not exist, it will be added. Will not remove metadata fields.

Returns all metadata saved by any app on the conversation.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.updateConversationMetadata(
        conversationId: "conversation-0",
        request: UpdateMetadataRequest(
            appId: "conversation-owning-app",
            values: [
                "key": "newValue"
            ]
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**conversationId:** `String` — The ID of the conversation to modify metadata for
    
</dd>
</dl>

<dl>
<dd>

**request:** `UpdateMetadataRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">search</a>(request: ConversationsSearchRequest, requestOptions: RequestOptions?) -> ConversationsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search conversations
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.search(request: ConversationsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">export</a>(request: ConversationsSearchRequest, requestOptions: RequestOptions?) -> Data</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Export conversations to a CSV file. 

This will output a summary of each conversation that matches the supplied filter. A maximum of 10,000 conversations can be exported at a time.

For most use cases it is recommended to use the `search` API instead and convert the JSON response to your desired format. 
The CSV format may change over time and should not be relied upon by code consumers.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.export(request: ConversationsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.conversation.<a href="/Sources/Resources/Conversation/ConversationClient.swift">deliverMessage</a>(request: DeliverMessageRequest, requestOptions: RequestOptions?) -> DeliverMessageResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Deliver a message to a user or conversation.

<Warning>
Currently, messages can only be successfully delivered to conversations with the `ASYNC` capability that are `open`. 
User message delivery is not yet supported.
</Warning>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.conversation.deliverMessage(request: DeliverMessageRequest.user(
        .init(
            userId: EntityIdWithoutAgent(
                type: .agent,
                appId: "appId",
                referenceId: "x"
            ),
            message: ConversationMessageRequest(
                conversationMessageId: EntityIdBase(
                    referenceId: "x"
                ),
                userId: EntityIdBase(
                    referenceId: "x"
                ),
                text: "text",
                userMessageType: .user
            )
        )
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `DeliverMessageRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Events
<details><summary><code>client.events.<a href="/Sources/Resources/Events/EventsClient.swift">create</a>(request: EventRequest, requestOptions: RequestOptions?) -> EventResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Create a new event
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.events.create(request: EventRequest.userEvent(
        .init(
            id: EntityIdBase(
                referenceId: "x"
            ),
            eventName: .buttonClicked,
            userInfo: EventUserInfoBase(
                id: EntityIdBase(
                    referenceId: "x"
                )
            )
        )
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `EventRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/Sources/Resources/Events/EventsClient.swift">search</a>(request: EventsSearchRequest, requestOptions: RequestOptions?) -> EventsSearchResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search events
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.events.search(request: EventsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `EventsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/Sources/Resources/Events/EventsClient.swift">get</a>(eventId: String, appId: String, requestOptions: RequestOptions?) -> EventResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieve details of a specific Event item by its ID.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.events.get(
        eventId: "eventId",
        request: .init(
            eventId: "eventId",
            appId: "appId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**eventId:** `String` — The ID of the Event to get.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String` — The App ID of the Event to retrieve
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.events.<a href="/Sources/Resources/Events/EventsClient.swift">export</a>(request: EventsSearchRequest, requestOptions: RequestOptions?) -> Data</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Export events to a CSV file.

This will output a summary of each event that matches the supplied filter. A maximum of 10,000 events can be exported at a time. For most use cases it is recommended to use the search API instead and convert the JSON response to your desired format. The CSV format may change over time and should not be relied upon by code consumers.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.events.export(request: EventsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `EventsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Inbox
<details><summary><code>client.inbox.<a href="/Sources/Resources/Inbox/InboxClient.swift">search</a>(request: InboxSearchRequest, requestOptions: RequestOptions?) -> InboxSearchResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieve a paginated list of inbox items for an agent.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.inbox.search(request: InboxSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `InboxSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.inbox.<a href="/Sources/Resources/Inbox/InboxClient.swift">get</a>(inboxItemId: String, appId: String, requestOptions: RequestOptions?) -> InboxItem</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieve details of a specific inbox item by its ID.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.inbox.get(
        inboxItemId: "inboxItemId",
        request: .init(
            inboxItemId: "inboxItemId",
            appId: "appId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**inboxItemId:** `String` — The ID of the inbox item to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String` — The App ID of the inbox item to retrieve
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.inbox.<a href="/Sources/Resources/Inbox/InboxClient.swift">getFix</a>(inboxItemFixId: String, appId: String, requestOptions: RequestOptions?) -> InboxItemFix</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieve a suggested fix. Includes document information if the fix is a Missing Knowledge suggestion.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.inbox.getFix(
        inboxItemFixId: "inboxItemFixId",
        request: .init(
            inboxItemFixId: "inboxItemFixId",
            appId: "appId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**inboxItemFixId:** `String` — Unique identifier for the inbox fix.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String` — The App ID of the inbox item fix to retrieve
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.inbox.<a href="/Sources/Resources/Inbox/InboxClient.swift">applyFixes</a>(inboxItemId: String, request: ApplyFixesRequest, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Apply a list of fixes belonging to an inbox item.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.inbox.applyFixes(
        inboxItemId: "inboxItemId",
        request: ApplyFixesRequest(
            appId: "appId",
            fixReferenceIds: [
                "fixReferenceIds",
                "fixReferenceIds"
            ]
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**inboxItemId:** `String` — Unique identifier for the inbox item.
    
</dd>
</dl>

<dl>
<dd>

**request:** `ApplyFixesRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.inbox.<a href="/Sources/Resources/Inbox/InboxClient.swift">ignore</a>(inboxItemId: String, appId: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Ignore a specific inbox item by its ID.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.inbox.ignore(
        inboxItemId: "inboxItemId",
        request: .init(
            inboxItemId: "inboxItemId",
            appId: "appId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**inboxItemId:** `String` — Unique identifier for the inbox item.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String` — The App ID of the inbox item fix to ignore
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Knowledge
<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">searchKnowledgeBases</a>(request: KnowledgeBaseSearchRequest, requestOptions: RequestOptions?) -> KnowledgeBasesResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search knowledge bases
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.searchKnowledgeBases(request: KnowledgeBaseSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `KnowledgeBaseSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">createOrUpdateKnowledgeBase</a>(request: KnowledgeBaseRequest, requestOptions: RequestOptions?) -> KnowledgeBaseResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update a knowledge base or create it if it doesn't exist.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.createOrUpdateKnowledgeBase(request: KnowledgeBaseRequest(
        knowledgeBaseId: EntityIdBase(
            referenceId: "help-center"
        ),
        name: "Help center"
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `KnowledgeBaseRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">getKnowledgeBase</a>(knowledgeBaseReferenceId: String, appId: String?, requestOptions: RequestOptions?) -> KnowledgeBaseResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an existing knowledge base by its supplied ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.getKnowledgeBase(
        knowledgeBaseReferenceId: "help-center",
        request: .init(knowledgeBaseReferenceId: "help-center")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the knowledge base to get. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">refreshKnowledgeBase</a>(knowledgeBaseReferenceId: String, request: KnowledgeBaseRefreshRequest, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Request that a knowledge base refresh itself.

Knowledge bases refresh on a schedule determined by the `refreshFrequency` field.
They can also be refreshed on demand by calling this endpoint.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.refreshKnowledgeBase(
        knowledgeBaseReferenceId: "help-center",
        request: KnowledgeBaseRefreshRequest(
            appId: "readme"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to refresh. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `KnowledgeBaseRefreshRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">patchKnowledgeBase</a>(knowledgeBaseReferenceId: String, request: Requests.KnowledgeBasePatchRequest, requestOptions: RequestOptions?) -> KnowledgeBaseResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable knowledge base fields

The `appId` field can be provided to update a knowledge base owned by a different app.
All other fields will overwrite the existing value on the knowledge base only if provided.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.patchKnowledgeBase(
        knowledgeBaseReferenceId: "help-center",
        request: .init(
            knowledgeBaseReferenceId: "help-center",
            name: "Updated Help Center",
            tags: ,
            segmentId: EntityId(
                referenceId: "premium-users",
                appId: "readme",
                organizationId: "acme",
                agentId: "support",
                type: .segment
            )
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to patch.
    
</dd>
</dl>

<dl>
<dd>

**request:** `Requests.KnowledgeBasePatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">createKnowledgeBaseVersion</a>(knowledgeBaseReferenceId: String, request: KnowledgeBaseVersionRequest, requestOptions: RequestOptions?) -> KnowledgeBaseVersion</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Create a new knowledge base version.

If an existing version is in progress, then that version will be finalized in an error state.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.createKnowledgeBaseVersion(
        knowledgeBaseReferenceId: "help-center",
        request: KnowledgeBaseVersionRequest(
            type: .full
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to create a version for. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `KnowledgeBaseVersionRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">finalizeKnowledgeBaseVersion</a>(knowledgeBaseReferenceId: String, request: FinalizeKnowledgeBaseVersionRequest, requestOptions: RequestOptions?) -> KnowledgeBaseVersion</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Finalize the latest knowledge base version. Required to indicate the version is complete. Will throw an exception if the latest version is not in progress.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.finalizeKnowledgeBaseVersion(
        knowledgeBaseReferenceId: "help-center",
        request: FinalizeKnowledgeBaseVersionRequest(
            versionId: EntityIdWithoutAgent(
                type: .knowledgeBaseVersion,
                referenceId: "versionId",
                appId: "maven"
            ),
            status: .succeeded
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to finalize a version for. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `FinalizeKnowledgeBaseVersionRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">listKnowledgeBaseVersions</a>(knowledgeBaseReferenceId: String, appId: String?, requestOptions: RequestOptions?) -> KnowledgeBaseVersionsListResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

List all active versions for a knowledge base. Returns the most recent versions first.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.listKnowledgeBaseVersions(
        knowledgeBaseReferenceId: "knowledgeBaseReferenceId",
        request: .init(knowledgeBaseReferenceId: "knowledgeBaseReferenceId")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to list versions for. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the knowledge base. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">searchKnowledgeDocuments</a>(request: KnowledgeDocumentSearchRequest, requestOptions: RequestOptions?) -> KnowledgeDocumentsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search knowledge documents
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.searchKnowledgeDocuments(request: KnowledgeDocumentSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `KnowledgeDocumentSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">createKnowledgeDocument</a>(knowledgeBaseReferenceId: String, request: KnowledgeDocumentRequest, requestOptions: RequestOptions?) -> KnowledgeDocumentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Create or update a knowledge document. Requires an existing knowledge base with an in progress version.
Will throw an exception if the latest version is not in progress.

<Tip>
This API maintains document version history. If for the same reference ID none of the `title`, `text`, `sourceUrl`, `metadata` fields
have changed, a new document version will not be created. The existing version will be reused.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.createKnowledgeDocument(
        knowledgeBaseReferenceId: "help-center",
        request: KnowledgeDocumentRequest(
            knowledgeDocumentId: EntityIdBase(
                referenceId: "getting-started"
            ),
            versionId: EntityIdWithoutAgent(
                type: .knowledgeBaseVersion,
                referenceId: "versionId",
                appId: "maven"
            ),
            contentType: .markdown,
            content: "## Getting started\nThis is a getting started guide for the help center.",
            title: "Getting started",
            metadata: [
                "category": "getting-started"
            ]
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to create a document for. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `KnowledgeDocumentRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">deleteKnowledgeDocument</a>(knowledgeBaseReferenceId: String, knowledgeDocumentReferenceId: String, request: KnowledgeDeleteRequest, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Delete knowledge document from a specific version.
Requires an existing knowledge base with an in progress version of type PARTIAL. Will throw an exception if the version is not in progress.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.deleteKnowledgeDocument(
        knowledgeBaseReferenceId: "help-center",
        knowledgeDocumentReferenceId: "getting-started",
        request: KnowledgeDeleteRequest(
            versionId: EntityIdWithoutAgent(
                type: .knowledgeBaseVersion,
                appId: "maven",
                referenceId: "versionId"
            )
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base that contains the document to delete. All other entity ID fields are inferred from the request
    
</dd>
</dl>

<dl>
<dd>

**knowledgeDocumentReferenceId:** `String` — The reference ID of the knowledge document to delete. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `KnowledgeDeleteRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">getKnowledgeDocument</a>(knowledgeBaseVersionReferenceId: String, knowledgeDocumentReferenceId: String, knowledgeBaseVersionAppId: String, requestOptions: RequestOptions?) -> KnowledgeDocumentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get a knowledge document by its supplied version and document IDs. Response includes document content in markdown format.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.getKnowledgeDocument(
        knowledgeBaseVersionReferenceId: "knowledgeBaseVersionReferenceId",
        knowledgeDocumentReferenceId: "knowledgeDocumentReferenceId",
        request: .init(
            knowledgeBaseVersionReferenceId: "knowledgeBaseVersionReferenceId",
            knowledgeDocumentReferenceId: "knowledgeDocumentReferenceId",
            knowledgeBaseVersionAppId: "knowledgeBaseVersionAppId"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseVersionReferenceId:** `String` — The reference ID of the knowledge base version that contains the document. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**knowledgeDocumentReferenceId:** `String` — The reference ID of the knowledge document to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**knowledgeBaseVersionAppId:** `String` — The App ID of the knowledge base version.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.knowledge.<a href="/Sources/Resources/Knowledge/KnowledgeClient.swift">patchKnowledgeDocument</a>(knowledgeBaseReferenceId: String, knowledgeDocumentReferenceId: String, request: Requests.KnowledgeDocumentPatchRequest, requestOptions: RequestOptions?) -> KnowledgeDocumentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable knowledge document fields that can be set independently of a knowledge base version.

For any changes in document content see the `createKnowledgeBaseVersion` and `createKnowledgeDocument` endpoints.

The `knowledgeBaseAppId` field can be provided to update a knowledge document in a knowledge base owned by a different app.
All other fields will overwrite the existing value on the knowledge document only if provided.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.knowledge.patchKnowledgeDocument(
        knowledgeBaseReferenceId: "help-center",
        knowledgeDocumentReferenceId: "how-it-works",
        request: .init(
            knowledgeBaseReferenceId: "help-center",
            knowledgeDocumentReferenceId: "how-it-works",
            llmInclusionStatus: .always
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**knowledgeBaseReferenceId:** `String` — The reference ID of the knowledge base to patch.
    
</dd>
</dl>

<dl>
<dd>

**knowledgeDocumentReferenceId:** `String` — The reference ID of the knowledge document to patch.
    
</dd>
</dl>

<dl>
<dd>

**request:** `Requests.KnowledgeDocumentPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Organizations
<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">create</a>(organizationReferenceId: String, request: CreateOrganizationRequest, requestOptions: RequestOptions?) -> Organization</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Create a new organization.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.create(
        organizationReferenceId: "organizationReferenceId",
        request: CreateOrganizationRequest(
            name: "name",
            defaultLanguage: "defaultLanguage"
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The reference ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**request:** `CreateOrganizationRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">get</a>(organizationReferenceId: String, requestOptions: RequestOptions?) -> Organization</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an organization by ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.get(organizationReferenceId: "organizationReferenceId")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The reference ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">patch</a>(organizationReferenceId: String, request: OrganizationPatchRequest, requestOptions: RequestOptions?) -> Organization</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable organization fields.
All fields will overwrite the existing value on the organization only if provided.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.patch(
        organizationReferenceId: "organizationReferenceId",
        request: OrganizationPatchRequest(

        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The reference ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**request:** `OrganizationPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">delete</a>(organizationReferenceId: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Delete an organization.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.delete(organizationReferenceId: "organizationReferenceId")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**organizationReferenceId:** `String` — The reference ID of the organization.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">getConversationTable</a>(request: ConversationTableRequest, requestOptions: RequestOptions?) -> ConversationTableResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Retrieves structured conversation data across all organizations, formatted as a table, 
allowing users to group, filter, and define specific metrics to display as columns.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.getConversationTable(request: ConversationTableRequest(
        conversationFilter: ConversationFilter(
            languages: [
                "en",
                "es"
            ]
        ),
        timeGrouping: .day,
        fieldGroupings: [
            ConversationGroupBy(
                field: .category
            )
        ],
        columnDefinitions: [
            ConversationColumnDefinition(
                header: "count",
                metric: ConversationMetric.count(
                    .init(

                    )
                )
            ),
            ConversationColumnDefinition(
                header: "avg_first_response_time",
                metric: ConversationMetric.average(
                    .init(
                        targetField: .firstResponseTime
                    )
                )
            ),
            ConversationColumnDefinition(
                header: "percentile_handle_time",
                metric: ConversationMetric.percentile(
                    .init(
                        targetField: .handleTime,
                        percentile: 25
                    )
                )
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationTableRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.organizations.<a href="/Sources/Resources/Organizations/OrganizationsClient.swift">getConversationChart</a>(request: ConversationChartRequest, requestOptions: RequestOptions?) -> ChartResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Fetches conversation data across all organizations, visualized in a chart format. 
Supported chart types include pie chart, date histogram, and stacked bar charts.

<Tip>
This endpoint requires additional permissions. Contact support to request access.
</Tip>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.organizations.getConversationChart(request: ConversationChartRequest.pieChart(
        .init(
            conversationFilter: ConversationFilter(
                languages: [
                    "en",
                    "es"
                ]
            ),
            groupBy: ConversationGroupBy(
                field: .category
            ),
            metric: ConversationMetric.count(
                .init(

                )
            )
        )
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `ConversationChartRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Segments
<details><summary><code>client.segments.<a href="/Sources/Resources/Segments/SegmentsClient.swift">search</a>(request: SegmentsSearchRequest, requestOptions: RequestOptions?) -> SegmentsSearchResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.segments.search(request: SegmentsSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `SegmentsSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.segments.<a href="/Sources/Resources/Segments/SegmentsClient.swift">createOrUpdate</a>(request: SegmentRequest, requestOptions: RequestOptions?) -> SegmentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update a segment or create it if it doesn't exist.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.segments.createOrUpdate(request: SegmentRequest(
        segmentId: EntityIdBase(
            referenceId: "admin-users"
        ),
        name: "Admin users",
        precondition: Precondition.group(
            .init(
                operator: .and,
                preconditions: [
                    Precondition.user(
                        .init(
                            key: "userKey"
                        )
                    ),
                    Precondition.user(
                        .init(
                            key: "userKey2"
                        )
                    )
                ]
            )
        )
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `SegmentRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.segments.<a href="/Sources/Resources/Segments/SegmentsClient.swift">get</a>(segmentReferenceId: String, appId: String?, requestOptions: RequestOptions?) -> SegmentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get a segment by its supplied ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.segments.get(
        segmentReferenceId: "admin-users",
        request: .init(segmentReferenceId: "admin-users")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**segmentReferenceId:** `String` — The reference ID of the segment to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the segment to get. If not provided, the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.segments.<a href="/Sources/Resources/Segments/SegmentsClient.swift">patch</a>(segmentReferenceId: String, request: SegmentPatchRequest, requestOptions: RequestOptions?) -> SegmentResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update mutable segment fields

The `appId` field can be provided to update a segment owned by a different app. 
All other fields will overwrite the existing value on the segment only if provided.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.segments.patch(
        segmentReferenceId: "segmentReferenceId",
        request: SegmentPatchRequest(

        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**segmentReferenceId:** `String` — The reference ID of the segment to update. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**request:** `SegmentPatchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Translations
<details><summary><code>client.translations.<a href="/Sources/Resources/Translations/TranslationsClient.swift">translate</a>(request: TranslationRequest, requestOptions: RequestOptions?) -> TranslationResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Translate text from one language to another
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.translations.translate(request: TranslationRequest(
        text: "Hello world",
        targetLanguage: "es"
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `TranslationRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Triggers
<details><summary><code>client.triggers.<a href="/Sources/Resources/Triggers/TriggersClient.swift">search</a>(request: EventTriggersSearchRequest, requestOptions: RequestOptions?) -> EventTriggersSearchResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.triggers.search(request: EventTriggersSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `EventTriggersSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.triggers.<a href="/Sources/Resources/Triggers/TriggersClient.swift">createOrUpdate</a>(request: EventTriggerRequest, requestOptions: RequestOptions?) -> EventTriggerResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update an event trigger or create it if it doesn't exist.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.triggers.createOrUpdate(request: EventTriggerRequest(
        triggerId: EntityIdBase(
            referenceId: "store-in-snowflake"
        ),
        description: "Stores conversation data in Snowflake",
        type: .conversationCreated
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `EventTriggerRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.triggers.<a href="/Sources/Resources/Triggers/TriggersClient.swift">get</a>(triggerReferenceId: String, requestOptions: RequestOptions?) -> EventTriggerResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an event trigger by its supplied ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.triggers.get(triggerReferenceId: "store-in-snowflake")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**triggerReferenceId:** `String` — The reference ID of the event trigger to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.triggers.<a href="/Sources/Resources/Triggers/TriggersClient.swift">delete</a>(triggerReferenceId: String, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Delete an event trigger
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.triggers.delete(triggerReferenceId: "store-in-snowflake")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**triggerReferenceId:** `String` — The reference ID of the event trigger to delete. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.triggers.<a href="/Sources/Resources/Triggers/TriggersClient.swift">partialUpdate</a>(triggerReferenceId: String, appId: String?, request: TriggerPartialUpdate, requestOptions: RequestOptions?) -> EventTriggerResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Updates an event trigger. Only the enabled field is editable.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.triggers.partialUpdate(
        triggerReferenceId: "triggerReferenceId",
        request: .init(
            triggerReferenceId: "triggerReferenceId",
            body: TriggerPartialUpdate(

            )
        )
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**triggerReferenceId:** `String` — The reference ID of the event trigger to update. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the trigger to update. If not provided, the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**request:** `TriggerPartialUpdate` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Users
<details><summary><code>client.users.<a href="/Sources/Resources/Users/UsersClient.swift">search</a>(request: AgentUserSearchRequest, requestOptions: RequestOptions?) -> AgentUserSearchResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Search across all agent users on an agent.

Agent users are a merged view of the users created by individual apps.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.users.search(request: AgentUserSearchRequest(

    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentUserSearchRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.users.<a href="/Sources/Resources/Users/UsersClient.swift">getAgentUser</a>(agentUserId: String, requestOptions: RequestOptions?) -> AgentUser</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an agent user by its supplied ID.

Agent users are a merged view of the users created by individual apps.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.users.getAgentUser(agentUserId: "aus_1234567890")
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**agentUserId:** `String` — The ID of the agent user to get.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.users.<a href="/Sources/Resources/Users/UsersClient.swift">createOrUpdate</a>(request: AppUserRequest, requestOptions: RequestOptions?) -> AppUserResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Update an app user or create it if it doesn't exist.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.users.createOrUpdate(request: AppUserRequest(
        userId: EntityIdBase(
            referenceId: "user-0"
        ),
        identifiers: ,
        data: [
            "name": UserData(
                value: "Joe",
                visibility: .visible
            )
        ]
    ))
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AppUserRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.users.<a href="/Sources/Resources/Users/UsersClient.swift">get</a>(userId: String, appId: String?, requestOptions: RequestOptions?) -> AppUserResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Get an app user by its supplied ID
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.users.get(
        userId: "user-0",
        request: .init(userId: "user-0")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**userId:** `String` — The reference ID of the app user to get. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the app user to get. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.users.<a href="/Sources/Resources/Users/UsersClient.swift">delete</a>(userId: String, appId: String?, requestOptions: RequestOptions?) -> Void</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Deletes all identifiers and user data saved by the specified app.
Does not modify data or identifiers saved by other apps.

If this user is linked to a user from another app, it will not be unlinked. Unlinking of users is not yet supported.

<Warning>This is a destructive operation and cannot be undone.</Warning>
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import Api

private func main() async throws {
    let client = MavenAGI(
        appId: "<username>",
        appSecret: "<password>"
    )

    try await client.users.delete(
        userId: "user-0",
        request: .init(userId: "user-0")
    )
}

try await main()
```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**userId:** `String` — The reference ID of the app user to delete. All other entity ID fields are inferred from the request.
    
</dd>
</dl>

<dl>
<dd>

**appId:** `String?` — The App ID of the app user to delete. If not provided the ID of the calling app will be used.
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

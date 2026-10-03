interface Client {
  id: number;
  name: string;
  region: string;
  level: number;
}

@Entry
@Component
struct Index {
  // Mock data for ForEach to ensure compilation without external dependencies
  private clients: Array<Client> = [
    { id: 1, name: 'Client A', region: 'North', level: 5 },
    { id: 2, name: 'Client B', region: 'South', level: 3 }
  ]

  build() {
    Stack() {
      Column() {
        // Header Section
        Stack() {
          Text('Client Detail')
            .padding({ top: 8, bottom: 8 })
            .fontColor('#000000') // colorScheme.onSurface approximation
            .fontSize(24) // typography.displayLarge approximation
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF') // colorScheme.background approximation

        // Scrollable Content
        Scroll() {
          Column() {
            // Regional Client Map Card
            Text('Regional Client Map')
              .padding({ top: 8 })
              .padding({ left: 12, right: 12 })
              .borderRadius(16) // AppTokens.Shapes.large approximation
              .linearGradient({
                angle: 90,
                colors: [['#FFB74D', 0], ['#FF7043', 1]]
              })
              .width('100%')
              .height(200)
              .fontColor('#FFFFFF')
              .fontSize(20) // typography.headlineMedium approximation

            // Placeholder for Image/Map (ZStack in skeleton)
            Stack()
              .width('100%')
              .height(360)
              .aspectRatio(0.9)

            // Client List Container
            Column() {
              ForEach(this.clients, (client: Client) => {
                Stack() {
                  Row() {
                    Column() {
                      Text(client.name)
                        .fontColor('#000000') // colorScheme.onSurface
                        .fontSize(16) // typography.titleMedium
                      
                      Text(client.region)
                        .fontColor('#000000') // colorScheme.onSurface
                        .fontSize(14) // typography.bodyMedium
                    }.alignItems(HorizontalAlign.Start).spacing(2) // AppTokens.Spacing.xs

                    Blank()

                    Text(`Level ${client.level}`)
                      .fontColor('#6200EE') // colorScheme.primary approximation
                      .fontSize(12) // typography.labelMedium
                  }
                  .padding(12) // AppTokens.Spacing.lg
                }
                .width('100%')
              })
            }
            .padding({ left: 12, right: 12 }) // AppTokens.Spacing.lg
            .padding({ bottom: 24 }) // AppTokens.Spacing.xxl
          }
          .spacing(8) // AppTokens.Spacing.md
        }
        .backgroundColor('#FFFFFF') // colorScheme.background
      }
    }
    .width('100%')
    .height('100%')
  }
}
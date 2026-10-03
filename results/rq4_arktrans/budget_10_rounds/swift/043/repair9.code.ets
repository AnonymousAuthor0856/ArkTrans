@Entry
@Component
struct Index {
  @State promo: string = ''

  build() {
    Stack() {
      // === WindowGroup ===
      // children: 1
      Column() {
        // === ZStack ===
        // props: {"hidden":"true"}
        // modifiers: ["statusBar(hidden: true)"]
        // children: 2
        Stack() {
          // === LinearGradient ===
          // props: {"gradient":"Gradient(colors: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant])","startPoint":".top","endPoint":".bottom"}
          // modifiers: ["ignoresSafeArea()"]
          // children: 1
          RectShape()
            .linearGradient({
              angle: 90,
              colors: [['#0A0A0A', 0], ['#1E1E1E', 1]]
            })
            .width('100%')
            .height('100%')
            .position({ x: 0, y: 0 })

          // === ScrollView ===
          // children: 1
          Scroll() {
            // === VStack ===
            // props: {"spacing":"AppTokens.Spacing.md","_positional_raw":["AppTokens.Spacing.lg"]}
            // modifiers: ["padding(AppTokens.Spacing.lg)"]
            // children: 7
            Column({ space: 8 }) {
              // === Text ===
              // props: {"text":"Your Cart","_text_raw":"\"Your Cart\"","_positional_raw":["AppTokens.TypographyTokens.display","AppTokens.Colors.primary"],"maxWidth":".infinity","alignment":".leading"}
              // modifiers: ["frame(maxWidth: .infinity, alignment: .leading)","foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.display)"]
              Text('Your Cart')
                .width('100%')
                .textAlign(TextAlign.Start)
                .fontColor('#00E5FF')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)

              // === ForEach ===
              // props: {"_positional_raw":["items"]}
              interface Item {
                name: string;
                price: string;
              }
              ForEach([
                { name: 'Neon Keyboard', price: '$89.99' },
                { name: 'Wireless Mouse', price: '$49.99' },
                { name: 'Gaming Headset', price: '$109.99' }
              ], (item: Item) => {
                Row() {
                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontColor('#FFFFFF')
                      .fontSize(18)
                    Text(item.price)
                      .fontColor('#00BFA5')
                      .fontSize(16)
                  }
                  Blank()
                  Button('Remove')
                    .backgroundColor('#00E5FF')
                    .fontColor('#0A0A0A')
                    .borderRadius(16)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#141414')
                .borderRadius(16)
              })

              // === Spacer ===
              // props: {"height":"AppTokens.Spacing.md"}
              // modifiers: ["frame(height: AppTokens.Spacing.md)"]
              Blank().height(8)

              // === HStack ===
              // children: 1
              Row() {
                // === TextField ===
                // props: {"text":"$promo","_text_raw":"\"\"","_positional_raw":"['AppTokens.TypographyTokens.body', 'AppTokens.Colors.onSurface', 'AppTokens.Spacing.md', 'AppTok...","when":"promo.isEmpty","RoundedRectangle...
                // modifiers: ["overlay( RoundedRectangle(cornerRadius: AppTokens.Shapes.medium) .stroke(AppT...","cornerRadius(AppTokens.Shapes.medium)","background(AppTokens.Colors.surfaceVariant)","padding(AppTokens.Spacing....
                // children: 2
                TextInput({ placeholder: 'Promo Code' })
                  .type(InputType.Normal)
                  .placeholderColor('#80FFFFFF')
                  .placeholderFont({ size: 14 })
                  .fontColor('#FFFFFF')
                  .fontSize(14)
                  .backgroundColor('#1E1E1E')
                  .borderRadius(12)
                  .border({ width: 1, color: '#2C2C2C' })
                  .padding(12)
                  .width('100%')
                  .height(48)
                  .onChange((value: string) => {
                    this.promo = value
                  })
              }

              // === Spacer ===
              // props: {"height":"AppTokens.Spacing.md"}
              // modifiers: ["frame(height: AppTokens.Spacing.md)"]
              Blank().height(8)

              // === VStack ===
              // props: {"spacing":"AppTokens.Spacing.sm","_positional_raw":["AppTokens.Spacing.lg","AppTokens.Colors.surfaceVariant","AppTokens.Shapes.large"],"maxWidth":".infinity","color":"AppTokens.Colors.background.o...
              // modifiers: ["shadow( color: AppTokens.Colors.background.opacity(AppTokens.ElevationMapping...","cornerRadius(AppTokens.Shapes.large)","background(AppTokens.Colors.surfaceVariant)","frame(maxWidth: .infinity)"...
              // children: 2
              Column({ space: 8 }) {
                // === HStack ===
                // children: 3
                Row() {
                  // === Text ===
                  // props: {"\"Items":"\"","_positional_raw":["AppTokens.TypographyTokens.body","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.body)"]
                  Text('Items:')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                  // === Spacer ===
                  Blank()
                  // === Text ===
                  // props: {"text":"\\(items.count)","_text_raw":"\"\\(items.count)\"","_positional_raw":["AppTokens.TypographyTokens.body","AppTokens.Colors.primary"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.body)"]
                  Text('3')
                    .fontColor('#00E5FF')
                    .fontSize(14)
                }
                .width('100%')

                // === HStack ===
                // children: 3
                Row() {
                  // === Text ===
                  // props: {"\"Total":"\"","_positional_raw":["AppTokens.TypographyTokens.title","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.title)"]
                  Text('Total:')
                    .fontColor('#FFFFFF')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  // === Spacer ===
                  Blank()
                  // === Text ===
                  // props: {"\"$\\(String(format":"\"%.2f\", total))\"","_text_raw":"\"\\(String(format:\"%.2f\", total))\"","_positional_raw":["AppTokens.TypographyTokens.title","AppTokens.Colors.primary"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.title)"]
                  Text('$249.97')
                    .fontColor('#00E5FF')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                }
                .width('100%')
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#1E1E1E')
              .borderRadius(16)

              // === Button ===
              // props: {"action":"{}"}
              // modifiers: ["buttonStyle(PlainButtonStyle())"]
              // children: 2
              Button() {
                // === Text ===
                // props: {"text":"Checkout","_text_raw":"\"Checkout\"","_positional_raw":"['AppTokens.TypographyTokens.title', 'AppTokens.Colors.onSecondary', 'AppTokens.Colors.secondary'...","maxWidth":".infinity","height...
                // modifiers: ["cornerRadius(AppTokens.Shapes.large)","background(AppTokens.Colors.secondary)","frame(height: 56)","frame(maxWidth: .infinity)","foregroundColor(AppTokens.Colors.onSecondary)","font(AppTokens.Typ...
                Text('Checkout')
                  .fontColor('#0A0A0A')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .height(56)
              .backgroundColor('#00BFA5')
              .borderRadius(16)
              .onClick(() => {
                // Checkout action
              })
            }
            .padding(16)
            .width('100%')
          }
          .width('100%')
          .height('100%')
          .align(Alignment.Top)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
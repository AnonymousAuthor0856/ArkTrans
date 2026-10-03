@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      // props: {"_positional_raw":[".all","true",".light"]}
      // modifiers: ["preferredColorScheme(.light)","statusBarHidden(true)","edgesIgnoringSafeArea(.all)"]
      // children: 2
      Stack() {
        // === LinearGradient ===
        // props: {"gradient":"Gradient(colors: [ AppTokens.Colors.secondary.opacity(0.25), AppTokens.Colors.background, AppToke...","startPoint":".top","endPoint":".bottom"}
        // modifiers: ["ignoresSafeArea()"]
        // children: 1
        // In ArkTS, gradients are applied via .linearGradient modifier on a container, not as a component constructor.
        // We use a blank Rect or Container to apply the gradient background.
        Rect()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 90,
            colors: [['#E0F2FE', 0], ['#FFFFFF', 0.5], ['#BAE6FD', 1]]
          })

        // === ScrollView ===
        // props: {"_positional_raw":[".vertical"],"showsIndicators":"false"}
        // children: 1
        Scroll() {
          // === VStack ===
          // props: {"alignment":".leading","spacing":"AppTokens.Spacing.lg","_positional_raw":["AppTokens.Spacing.lg"]}
          // modifiers: ["padding(AppTokens.Spacing.lg)"]
          // children: 4
          Column({ space: 24 }) {
            // === Text ===
            // props: {"text":"Cold Gradient Price Compare","_text_raw":"\"Cold Gradient Price Compare\"","_positional_raw":["AppTokens.TypographyTokens.display","AppTokens.Colors.onBackground"]}
            // modifiers: ["foregroundColor(AppTokens.Colors.onBackground)","font(AppTokens.TypographyTokens.display)"]
            Text('Cold Gradient Price Compare').fontColor('#0F172A').fontSize(26).fontWeight(FontWeight.Bold)

            // === LazyVGrid ===
            // props: {"columns":"[GridItem(.flexible()), GridItem(.flexible())]","spacing":"AppTokens.Spacing.md","_positional_raw":[".bottom","AppTokens.Spacing.xxl"]}
            // modifiers: ["padding(.bottom, AppTokens.Spacing.xxl)"]
            // children: 1
            Grid() {
              // === ForEach ===
              // props: {"_positional_raw":["products"]}
              // children: 1
              ForEach([
                { name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
                { name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
                { name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
                { name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' }
              ], (item: ProductItem) => {
                // === VStack ===
                // props: {"spacing":"AppTokens.Spacing.sm","_positional_raw":["AppTokens.Spacing.md","AppTokens.Colors.surface","AppTokens.Shapes.large"],"color":"Color.black.opacity(AppTokens.ElevationMapping.level1.opaci...
                // modifiers: ["shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),...","cornerRadius(AppTokens.Shapes.large)","background(AppTokens.Colors.surface)","padding(AppTokens.Spacing.md)"]
                // children: 5
                GridItem() {
                  Column({ space: 8 }) {
                    // === Rectangle ===
                    // props: {"_positional_raw":["AppTokens.Colors.surfaceVariant","AppTokens.Shapes.medium"],"width":"100","height":"100"}
                    // modifiers: ["cornerRadius(AppTokens.Shapes.medium)","frame(width: 100, height: 100)","fill(AppTokens.Colors.surfaceVariant)"]
                    Rect().borderRadius(12).width(100).height(100).fill('#DFF1FD')

                    // === Text ===
                    // props: {"_positional_raw":["product.name","AppTokens.TypographyTokens.title","AppTokens.Colors.onSurface"]}
                    // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.title)"]
                    Text(item.name).fontColor('#0F172A').fontSize(18).fontWeight(FontWeight.Medium)

                    // === Text ===
                    // props: {"_positional_raw":["product.price","AppTokens.TypographyTokens.body","AppTokens.Colors.primary"]}
                    // modifiers: ["foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.body)"]
                    Text(item.price).fontColor('#0EA4E9').fontSize(16).fontWeight(FontWeight.Medium)

                    // === Text ===
                    // props: {"_positional_raw":["product.store","AppTokens.TypographyTokens.label","AppTokens.Colors.tertiary"]}
                    // modifiers: ["foregroundColor(AppTokens.Colors.tertiary)","font(AppTokens.TypographyTokens.label)"]
                    Text(item.store).fontColor('#93C5FD').fontSize(14)

                    // === Button ===
                    // props: {"action":"{}","_positional_raw":["AppTokens.Colors.primary","AppTokens.Shapes.medium"]}
                    // modifiers: ["cornerRadius(AppTokens.Shapes.medium)","background(AppTokens.Colors.primary)"]
                    Button() {
                      Text('Compare').fontColor('#FFFFFF').fontSize(14)
                    }.borderRadius(12).backgroundColor('#0EA4E9').width('100%').height(40)
                  }.backgroundColor('#FFFFFF').padding(16).borderRadius(24).shadow({ radius: 8, color: '#1F000000' })
                }
              })
            }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).padding({ bottom: 24 }).width('100%')

            // === Text ===
            // props: {"text":"Price Update Log","_text_raw":"\"Price Update Log\"","_positional_raw":["AppTokens.TypographyTokens.title","AppTokens.Colors.primary"]}
            // modifiers: ["foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.title)"]
            Text('Price Update Log').fontColor('#0EA4E9').fontSize(18).fontWeight(FontWeight.Medium)

            // === LazyVStack ===
            // props: {"spacing":"AppTokens.Spacing.sm","_positional_raw":[".bottom","48"]}
            // modifiers: ["padding(.bottom, 48)"]
            // children: 1
            Column({ space: 12 }) {
              // === ForEach ===
              // props: {"_positional_raw":["products"]}
              // children: 1
              ForEach([
                { name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
                { name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
                { name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
                { name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' }
              ], (item: ProductItem) => {
                // === HStack ===
                // props: {"_positional_raw":["AppTokens.Spacing.md","AppTokens.Colors.surface","AppTokens.Shapes.small"]}
                // modifiers: ["cornerRadius(AppTokens.Shapes.small)","background(AppTokens.Colors.surface)","padding(AppTokens.Spacing.md)"]
                // children: 3
                Row() {
                  // === Text ===
                  // props: {"text":"\\(product.name) (\\(product.store))","_text_raw":"\"\\(product.name) (\\(product.store))\"","_positional_raw":["AppTokens.TypographyTokens.body","AppTokens.Colors.onSurface"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.body)"]
                  Text(`${item.name} (${item.store})`).fontColor('#0F172A').fontSize(14)

                  // === Spacer ===
                  Blank()

                  // === Text ===
                  // props: {"_positional_raw":["product.price","AppTokens.TypographyTokens.label","AppTokens.Colors.secondary"]}
                  // modifiers: ["foregroundColor(AppTokens.Colors.secondary)","font(AppTokens.TypographyTokens.label)"]
                  Text(item.price).fontColor('#0EA4E9').fontSize(14).fontWeight(FontWeight.Medium)
                }.backgroundColor('#FFFFFF').padding(16).borderRadius(12).width('100%')
              })
            }.padding({ bottom: 48 })
          }.padding(24).width('100%')
        }
      }
    }.width('100%').height('100%')
  }
}

interface ProductItem {
  name: string;
  price: string;
  store: string;
}
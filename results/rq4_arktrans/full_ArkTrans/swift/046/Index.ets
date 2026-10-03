@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.TopStart }) {
        // === LinearGradient ===
        // props: {"gradient":"Gradient(colors: [ AppTokens.Colors.secondary.opacity(0.25), AppTokens.Colors.background, AppToke...","startPoint":".top","endPoint":".bottom","_positional_raw":[".all"]}
        // modifiers: ["edgesIgnoringSafeArea(.all)"]
        // children: 1
        Column() {
          // === Gradient ===
          // props: {"colors":"[ AppTokens.Colors.secondary.opacity(0.25), AppTokens.Colors.background, AppTokens.Colors.primary..."}
          // Note: ArkTS doesn't have a direct equivalent to SwiftUI's Gradient/LinearGradient in the same way. 
          // We'll use a simple background color for now as a placeholder.
          // In a real app, you might use a custom component or a library that supports gradients.
          Text('').width('100%').height('100%').backgroundColor('#F0F2F8')
        }.width('100%').height('100%')

        // === VStack ===
        // props: {"spacing":"AppTokens.Spacing.lg"}
        // children: 2
        Column({ space: 16 }) {
          // === HStack ===
          // props: {"_positional_raw":[".top","AppTokens.Spacing.lg"]}
          // modifiers: ["padding(.top, AppTokens.Spacing.lg)"]
          // children: 5
          Row() {
            // === Button ===
            // props: {"action":"{}","_positional_raw":[".leading","AppTokens.Spacing.lg"]}
            // modifiers: ["padding(.leading, AppTokens.Spacing.lg)"]
            // children: 1
            Button() {
              // === Circle ===
              // props: {"_positional_raw":["appColorScheme.onSurface"],"width":"20","height":"20"}
              // modifiers: ["frame(width: 20, height: 20)","fill(appColorScheme.onSurface)"]
              Circle().width(20).height(20).fill('#1A1B1E')
            }.padding({ left: 12 })
            // === Spacer ===
            Blank()
            // === Text ===
            // props: {"text":"Coupon Pack","_text_raw":"\"Coupon Pack\"","_positional_raw":["AppTokens.TypographyTokens.display()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.display())"]
            Text('Coupon Pack').fontColor('#1A1B1E').fontSize(32).fontWeight(FontWeight.Bold)
            // === Spacer ===
            Blank()
            // === Button ===
            // props: {"action":"{}","_positional_raw":[".trailing","AppTokens.Spacing.lg"]}
            // modifiers: ["padding(.trailing, AppTokens.Spacing.lg)"]
            // children: 1
            Button() {
              // === Circle ===
              // props: {"_positional_raw":["appColorScheme.primary"],"width":"20","height":"20"}
              // modifiers: ["frame(width: 20, height: 20)","fill(appColorScheme.primary)"]
              Circle().width(20).height(20).fill('#7B61FF')
            }.padding({ right: 12 })
          }.padding({ top: 12 })

          // === VStack ===
          // props: {"alignment":".leading","spacing":"AppTokens.Spacing.lg","_positional_raw":[".horizontal","AppTokens.Spacing.lg"]}
          // modifiers: ["padding(.horizontal, AppTokens.Spacing.lg)"]
          // children: 6
          Column({ space: 16 }) {
            // === Text ===
            // props: {"text":"Nearby Packs","_text_raw":"\"Nearby Packs\"","_positional_raw":["AppTokens.TypographyTokens.headline()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.headline())"]
            Text('Nearby Packs').fontColor('#1A1B1E').fontSize(24).fontWeight(FontWeight.Medium)

            // === ZStack ===
            // props: {"alignment":".topTrailing"}
            // children: 2
            Stack({ alignContent: Alignment.TopEnd }) {
              // === RoundedRectangle ===
              // props: {"cornerRadius":"AppTokens.Shapes.largeCornerRadius","_positional_raw":["appColorScheme.surface","16 / 9"],"contentMode":".fit","Canvas { context, size in // drawRect(color = AppTokens.Colors.surfa...
              // modifiers: ["shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),...","overlay( // Canvas 用于绘制地图和图钉 Canvas { context, size in // drawRect(color = 0xFFF0F2F8) context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(0xFFF0F2F8)) // 绘制地图图钉 for pin in pins { // drawCircle(color = p.tint, radius = 14f, center = Offset(p.x, p.y)) // SwiftUI Canvas 的 Path(ellipseIn:) 使用 CGRect，中心点为 (x+w/2, y+h/2) // 半径 14f 对应直径 28 context.fill(Path(ellipseIn: CGRect(x: pin.x - 14, y: pin.y - 14, width: 28, height: 28)), with: .color(pin.tint)) } } .padding(8) // .padding(8) ).aspectRatio(16 / 9, contentMo...
              // children: 1
              Rect().borderRadius(24).shadow({ radius: 8, color: '#1F000000', offsetY: 4 }).width('100%').height(200).backgroundColor('#FFFFFF')

              // === HStack ===
              // props: {"spacing":"AppTokens.Spacing.sm","_positional_raw":[".horizontal","AppTokens.Spacing.md",".vertical","AppTokens.Spacing.xs","AppTokens.Spacing.md"],"RoundedRectangle(cornerRadius":"AppTokens.Shape...
              // modifiers: ["padding(AppTokens.Spacing.md)","background( RoundedRectangle(cornerRadius: AppTokens.Shapes.smallCornerRadius...","padding(.vertical, AppTokens.Spacing.xs)","padding(.horizontal, AppTokens.Spacin...
              // children: 7
              Row({ space: 8 }) {
                // === Circle ===
                // props: {"_positional_raw":["AppTokens.Colors.primary"],"width":"10","height":"10"}
                // modifiers: ["frame(width: 10, height: 10)","fill(AppTokens.Colors.primary)"]
                Circle().width(10).height(10).fill('#7B61FF')
                // === Text ===
                // props: {"text":"A","_text_raw":"\"A\"","_positional_raw":["AppTokens.TypographyTokens.label()","appColorScheme.onSurface"]}
                // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.label())"]
                Text('A').fontColor('#1A1B1E').fontSize(14).fontWeight(FontWeight.Medium)
                // === Circle ===
                // props: {"_positional_raw":["AppTokens.Colors.secondary"],"width":"10","height":"10"}
                // modifiers: ["frame(width: 10, height: 10)","fill(AppTokens.Colors.secondary)"]
                Circle().width(10).height(10).fill('#26C6DA')
                // === Text ===
                // props: {"text":"B","_text_raw":"\"B\"","_positional_raw":["AppTokens.TypographyTokens.label()","appColorScheme.onSurface"]}
                // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.label())"]
                Text('B').fontColor('#1A1B1E').fontSize(14).fontWeight(FontWeight.Medium)
                // === Circle ===
                // props: {"_positional_raw":["AppTokens.Colors.tertiary"],"width":"10","height":"10"}
                // modifiers: ["frame(width: 10, height: 10)","fill(AppTokens.Colors.tertiary)"]
                Circle().width(10).height(10).fill('#FF8A80')
                // === Text ===
                // props: {"text":"C","_text_raw":"\"C\"","_positional_raw":["AppTokens.TypographyTokens.label()","appColorScheme.onSurface"]}
                // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.label())"]
                Text('C').fontColor('#1A1B1E').fontSize(14).fontWeight(FontWeight.Medium)
                // === RoundedRectangle ===
                // props: {"cornerRadius":"AppTokens.Shapes.smallCornerRadius","_positional_raw":["appColorScheme.surface.opacity(0.9)"]}
                // modifiers: ["fill(appColorScheme.surface.opacity(0.9))"]
                Rect().borderRadius(8).width(20).height(20).backgroundColor('#FFFFFF')
              }.padding(8).backgroundColor('#FFFFFF').borderRadius(16)
            }

            // === Text ===
            // props: {"text":"Your Coupon Packs","_text_raw":"\"Your Coupon Packs\"","_positional_raw":["AppTokens.TypographyTokens.headline()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.headline())"]
            Text('Your Coupon Packs').fontColor('#1A1B1E').fontSize(24).fontWeight(FontWeight.Medium)

            // === ScrollView ===
            // props: {"_positional_raw":[".horizontal"],"showsIndicators":"false"}
            // children: 1
            Scroll() {
              // === LazyHStack ===
              // props: {"spacing":"AppTokens.Spacing.lg","_positional_raw":[".horizontal","AppTokens.Spacing.xs"]}
              // modifiers: ["padding(.horizontal, AppTokens.Spacing.xs)"]
              // children: 1
              Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
                // === ForEach ===
                // props: {"_positional_raw":["coupons"]}
                // children: 1
                // Simulating ForEach with two static items
                // === ZStack ===
                // props: {"width":"200","height":"140"}
                // modifiers: ["frame(width: 200, height: 140)"]
                // children: 2
                Stack({ alignContent: Alignment.TopStart }) {
                  // === RoundedRectangle ===
                  // props: {"cornerRadius":"AppTokens.Shapes.largeCornerRadius","_positional_raw":["appColorScheme.surface"],"color":"Color.black.opacity(AppTokens.ElevationMapping.level2.opacity)","radius":"AppTokens.Elevat...
                  // modifiers: ["shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),...","fill(appColorScheme.surface)"]
                  Rect().borderRadius(24).shadow({ radius: 8, color: '#1F000000', offsetY: 4 }).width(200).height(140).backgroundColor('#FFFFFF')
                  // === VStack ===
                  // props: {"alignment":".leading","spacing":"AppTokens.Spacing.sm","_positional_raw":["AppTokens.Spacing.lg","AppTokens.Shapes.largeCornerRadius"],"LinearGradient( gradient":"Gradient(colors: [coupon.colorA....
                  // modifiers: ["cornerRadius(AppTokens.Shapes.largeCornerRadius)","background( // 卡片内部渐变背景 LinearGradient( gradient: Gradient(colors: [coupon.co...","padding(AppTokens.Spacing.lg)"]
                  // children: 4
                  Column({ space: 8 }) {
                    // === HStack ===
                    // props: {"spacing":"AppTokens.Spacing.sm"}
                    // children: 2
                    Row({ space: 8 }) {
                      // === Circle ===
                      // props: {"_positional_raw":["appColorScheme.primary"],"width":"14","height":"14"}
                      // modifiers: ["frame(width: 14, height: 14)","fill(appColorScheme.primary)"]
                      Circle().width(14).height(14).fill('#7B61FF')
                      // === Text ===
                      // props: {"_positional_raw":["coupon.title","AppTokens.TypographyTokens.title()","appColorScheme.onSurface"]}
                      // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.title())"]
                      Text('Grocery Pack').fontColor('#1A1B1E').fontSize(18).fontWeight(FontWeight.Medium)
                    }
                    // === Text ===
                    // props: {"_positional_raw":["coupon.value","AppTokens.TypographyTokens.display()","appColorScheme.onSurface"]}
                    // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.display())"]
                    Text('-$5').fontColor('#1A1B1E').fontSize(32).fontWeight(FontWeight.Bold)
                    // === Button ===
                    // props: {"action":"{}"}
                    // children: 1
                    Button() {
                      // === Text ===
                      // props: {"text":"Redeem","_text_raw":"\"Redeem\"","_positional_raw":"['AppTokens.TypographyTokens.label()', 'appColorScheme.primary', 'appColorScheme.onPrimary', 'App...","maxWidth":".infinity","height":"40"}
                      // modifiers: ["cornerRadius(AppTokens.Shapes.mediumCornerRadius)","foregroundColor(appColorScheme.onPrimary)","background(appColorScheme.primary)","frame(height: 40)","frame(maxWidth: .infinity)","font(AppToken...
                      Text('Redeem').borderRadius(16).fontColor('#FFFFFF').backgroundColor('#7B61FF').height(40).width('100%').fontSize(14).fontWeight(FontWeight.Medium)
                    }
                    // === LinearGradient ===
                    // props: {"gradient":"Gradient(colors: [coupon.colorA.opacity(0.18), coupon.colorB.opacity(0.18)])","startPoint":".leading","endPoint":".trailing"}
                    // children: 1
                    // Note: ArkTS doesn't have a direct equivalent to SwiftUI's LinearGradient in the same way. 
                    // We'll use a simple background color for now as a placeholder.
                    // In a real app, you might use a custom component or a library that supports gradients.
                    Text('').width('100%').height('100%').backgroundColor('#F0F2F8')
                  }.padding(16).borderRadius(24).width('100%').height('100%')
                }.margin({ right: 16 })

                // Second coupon card
                Stack({ alignContent: Alignment.TopStart }) {
                  Rect().borderRadius(24).shadow({ radius: 8, color: '#1F000000', offsetY: 4 }).width(200).height(140).backgroundColor('#FFFFFF')
                  Column({ space: 8 }) {
                    Row({ space: 8 }) {
                      Circle().width(14).height(14).fill('#7B61FF')
                      Text('Cafe Bundle').fontColor('#1A1B1E').fontSize(18).fontWeight(FontWeight.Medium)
                    }
                    Text('-15%').fontColor('#1A1B1E').fontSize(32).fontWeight(FontWeight.Bold)
                    Button() {
                      Text('Redeem').borderRadius(16).fontColor('#FFFFFF').backgroundColor('#7B61FF').height(40).width('100%').fontSize(14).fontWeight(FontWeight.Medium)
                    }
                    Text('').width('100%').height('100%').backgroundColor('#F0F2F8')
                  }.padding(16).borderRadius(24).width('100%').height('100%')
                }
              }.padding({ left: 8, right: 8 })
            }

            // === Spacer ===
            // props: {"minLength":"AppTokens.Spacing.sm"}
            Blank()

            // === HStack ===
            // props: {"spacing":"AppTokens.Spacing.md"}
            // children: 2
            Row({ space: 16 }) {
              // === Button ===
              // props: {"action":"{}"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"text":"My Coupons","_text_raw":"\"My Coupons\"","_positional_raw":"['AppTokens.TypographyTokens.title()', 'appColorScheme.secondary', 'appColorScheme.onSecondary', ...","maxWidth":".infinity","he...
                // modifiers: ["cornerRadius(AppTokens.Shapes.largeCornerRadius)","foregroundColor(appColorScheme.onSecondary)","background(appColorScheme.secondary)","frame(height: 52)","frame(maxWidth: .infinity)","font(AppTo...
                Text('My Coupons').borderRadius(24).fontColor('#1A1B1E').backgroundColor('#26C6DA').height(52).width('100%').fontSize(18).fontWeight(FontWeight.Medium)
              }
              // === Button ===
              // props: {"action":"{}"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"text":"Explore More","_text_raw":"\"Explore More\"","_positional_raw":"['AppTokens.TypographyTokens.title()', 'appColorScheme.primary', 'appColorScheme.onPrimary', 'App...","maxWidth":".infinity"...
                // modifiers: ["cornerRadius(AppTokens.Shapes.largeCornerRadius)","foregroundColor(appColorScheme.onPrimary)","background(appColorScheme.primary)","frame(height: 52)","frame(maxWidth: .infinity)","font(AppTokens...
                Text('Explore More').borderRadius(24).fontColor('#FFFFFF').backgroundColor('#7B61FF').height(52).width('100%').fontSize(18).fontWeight(FontWeight.Medium)
              }
            }
          }.padding({ left: 16, right: 16 })
        }
      }
    }.width('100%').height('100%')
  }
}
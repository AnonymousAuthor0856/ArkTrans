@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === WindowGroup ===
      // children: 1
      // In ArkTS, WindowGroup is not a UI component but a lifecycle concept. 
      // We render the content directly inside the Stack as per the skeleton structure.
      
      // === ZStack ===
      // props: {"_positional_raw":[".all","true"]}
      // modifiers: ["statusBarHidden(true)","edgesIgnoringSafeArea(.all)"]
      // children: 2
      Stack({ alignContent: Alignment.Center }) {
        // === LinearGradient ===
        // props: {"gradient":"Gradient(colors: [ AppTokens.Colors.secondary.opacity(0.25), AppTokens.Colors.background, AppToke...","startPoint":".top","endPoint":".bottom","_positional_raw":[".all"]}
        // modifiers: ["edgesIgnoringSafeArea(.all)"]
        // children: 1
        // Note: ArkTS does not have a direct LinearGradient component that acts as a container like SwiftUI.
        // We use .linearGradient modifier on a background shape or the stack itself.
        // To mimic the structure, we place a full-screen Rect with linear gradient.
        Rect()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Top,
            colors: [
              ['#7B61FF', 0], // Secondary approx
              ['#FFFFFF', 0.5], // Background approx
              ['#6200EE', 1]   // Primary approx
            ]
          })

        // === VStack ===
        // props: {"spacing":"AppTokens.Spacing.lg"}
        // children: 2
        Column({ space: 24 }) {
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
              Circle().width(20).height(20).fill('#1C1B1F') // onSurface approx
            }.padding({ left: 12 })

            // === Spacer ===
            Blank()

            // === Text ===
            // props: {"text":"Coupon Pack","_text_raw":"\"Coupon Pack\"","_positional_raw":["AppTokens.TypographyTokens.display()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.display())"]
            Text('Coupon Pack').fontColor('#1C1B1F').fontSize(32) // Display approx

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
              Circle().width(20).height(20).fill('#6200EE') // Primary approx
            }.padding({ right: 12 })
          }.padding({ top: 24 })

          // === VStack ===
          // props: {"alignment":".leading","spacing":"AppTokens.Spacing.lg","_positional_raw":[".horizontal","AppTokens.Spacing.lg"]}
          // modifiers: ["padding(.horizontal, AppTokens.Spacing.lg)"]
          // children: 6
          Column({ space: 24 }) {
            // === Text ===
            // props: {"text":"Nearby Packs","_text_raw":"\"Nearby Packs\"","_positional_raw":["AppTokens.TypographyTokens.headline()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.headline())"]
            Text('Nearby Packs').fontColor('#1C1B1F').fontSize(28) // Headline approx

            // === ZStack ===
            // props: {"alignment":".topTrailing"}
            // children: 2
            Stack({ alignContent: Alignment.TopEnd }) {
              // === RoundedRectangle ===
              // props: {"cornerRadius":"AppTokens.Shapes.largeCornerRadius","_positional_raw":["appColorScheme.surface","16 / 9"],"contentMode":".fit","Canvas { context, size in // drawRect(color = AppTokens.Colors.surfa...
              // modifiers: ["shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),...","overlay( // Canvas 用于绘制地图和图钉 Canvas { context, size in // drawRect(color = 0xFFF0F2F8) context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(0xFFF0F2F8)) // 绘制地图图钉 for pin in pins { // drawCircle(color = p.tint, radius = 14f, center = Offset(p.x, p.y)) // SwiftUI Canvas 的 Path(ellipseIn:) 使用 CGRect，中心点为 (x+w/2, y+h/2) // 半径 14f 对应直径 28 context.fill(Path(ellipseIn: CGRect(x: pin.x - 14, y: pin.y - 14, width: 28, height: 28)), with: .color(pin.tint)) } } .padding(8) // .padding(8) ).aspectRatio(16 / 9, contentMo...
              // children: 1
              // Simplified Map Placeholder
              Rect()
                .borderRadius(16)
                .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
                .aspectRatio(16 / 9)
                .width('100%')
                .backgroundColor('#F0F2F8') // Surface approx

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
                Text('A').fontColor('#1C1B1F').fontSize(14)

                // === Circle ===
                // props: {"_positional_raw":["AppTokens.Colors.secondary"],"width":"10","height":"10"}
                // modifiers: ["frame(width: 10, height: 10)","fill(AppTokens.Colors.secondary)"]
                Circle().width(10).height(10).fill('#26C6DA')

                // === Text ===
                // props: {"text":"B","_text_raw":"\"B\"","_positional_raw":["AppTokens.TypographyTokens.label()","appColorScheme.onSurface"]}
                // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.label())"]
                Text('B').fontColor('#1C1B1F').fontSize(14)

                // === Circle ===
                // props: {"_positional_raw":["AppTokens.Colors.tertiary"],"width":"10","height":"10"}
                // modifiers: ["frame(width: 10, height: 10)","fill(AppTokens.Colors.tertiary)"]
                Circle().width(10).height(10).fill('#FF8A80')

                // === Text ===
                // props: {"text":"C","_text_raw":"\"C\"","_positional_raw":["AppTokens.TypographyTokens.label()","appColorScheme.onSurface"]}
                // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.label())"]
                Text('C').fontColor('#1C1B1F').fontSize(14)

                // === RoundedRectangle ===
                // props: {"cornerRadius":"AppTokens.Shapes.smallCornerRadius","_positional_raw":["appColorScheme.surface.opacity(0.9)"]}
                // modifiers: ["fill(appColorScheme.surface.opacity(0.9))"]
                Rect().borderRadius(8).width(20).height(20).fill('rgba(255,255,255,0.9)')
              }
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .padding({ top: 4, bottom: 4, left: 8, right: 8 })
            }

            // === Text ===
            // props: {"text":"Your Coupon Packs","_text_raw":"\"Your Coupon Packs\"","_positional_raw":["AppTokens.TypographyTokens.headline()","appColorScheme.onSurface"]}
            // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.headline())"]
            Text('Your Coupon Packs').fontColor('#1C1B1F').fontSize(28)

            // === ScrollView ===
            // props: {"_positional_raw":[".horizontal"],"showsIndicators":"false"}
            // children: 1
            Scroll() {
              // === LazyHStack ===
              // props: {"spacing":"AppTokens.Spacing.lg","_positional_raw":[".horizontal","AppTokens.Spacing.xs"]}
              // modifiers: ["padding(.horizontal, AppTokens.Spacing.xs)"]
              // children: 1
              // Note: ArkTS uses List/Grid for lazy loading. For a simple horizontal scroll of fixed items, 
              // we can use a Row inside Scroll or a Grid with 1 row. 
              // Given "LazyHStack" and "ForEach", a Grid with 1 row is the closest semantic match for performance,
              // but a Row is simpler for this static skeleton. Let's use Row for simplicity as no data source is provided.
              Row({ space: 24 }) {
                // === ForEach ===
                // props: {"_positional_raw":["coupons"]}
                // children: 1
                // Simulating one item from ForEach
                // === ZStack ===
                // props: {"width":"200","height":"140"}
                // modifiers: ["frame(width: 200, height: 140)"]
                // children: 2
                Stack({ alignContent: Alignment.Center }) {
                  // === RoundedRectangle ===
                  // props: {"cornerRadius":"AppTokens.Shapes.largeCornerRadius","_positional_raw":["appColorScheme.surface"],"color":"Color.black.opacity(AppTokens.ElevationMapping.level2.opacity)","radius":"AppTokens.Elevat...
                  // modifiers: ["shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),...","fill(appColorScheme.surface)"]
                  Rect()
                    .width(200)
                    .height(140)
                    .borderRadius(16)
                    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
                    .backgroundColor('#FFFFFF')

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
                      Circle().width(14).height(14).fill('#6200EE')

                      // === Text ===
                      // props: {"_positional_raw":["coupon.title","AppTokens.TypographyTokens.title()","appColorScheme.onSurface"]}
                      // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.title())"]
                      Text('Title').fontColor('#1C1B1F').fontSize(18)
                    }

                    // === Text ===
                    // props: {"_positional_raw":["coupon.value","AppTokens.TypographyTokens.display()","appColorScheme.onSurface"]}
                    // modifiers: ["foregroundColor(appColorScheme.onSurface)","font(AppTokens.TypographyTokens.display())"]
                    Text('$10 Off').fontColor('#1C1B1F').fontSize(32)

                    // === Button ===
                    // props: {"action":"{}"}
                    // children: 1
                    Button() {
                      // === Text ===
                      // props: {"text":"Redeem","_text_raw":"\"Redeem\"","_positional_raw":"['AppTokens.TypographyTokens.label()', 'appColorScheme.primary', 'appColorScheme.onPrimary', 'App...","maxWidth":".infinity","height":"40"}
                      // modifiers: ["cornerRadius(AppTokens.Shapes.mediumCornerRadius)","foregroundColor(appColorScheme.onPrimary)","background(appColorScheme.primary)","frame(height: 40)","frame(maxWidth: .infinity)","font(AppToken...
                      Text('Redeem')
                        .fontColor('#FFFFFF')
                        .fontSize(14)
                    }
                    .backgroundColor('#6200EE')
                    .borderRadius(8)
                    .height(40)
                    .width('100%')

                    // === LinearGradient ===
                    // props: {"gradient":"Gradient(colors: [coupon.colorA.opacity(0.18), coupon.colorB.opacity(0.18)])","startPoint":".leading","endPoint":".trailing"}
                    // children: 1
                    // This seems to be a background overlay in the original SwiftUI code based on modifiers.
                    // In ArkTS, we apply it to the parent or a background rect.
                    // Since it's a child here in the skeleton, we'll add a transparent rect with gradient at the bottom.
                    Rect()
                      .width('100%')
                      .height(10)
                      .linearGradient({
                        direction: GradientDirection.Start,
                        colors: [
                          ['#6200EE', 0],
                          ['#7B61FF', 1]
                        ]
                      })
                      .opacity(0.18)
                  }
                  .padding(16)
                  .width('100%')
                  .height('100%')
                  .alignItems(HorizontalAlign.Start)
                }
                .width(200)
                .height(140)
              }
              .padding({ left: 4, right: 4 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .width('100%')

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
                Text('My Coupons')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
              }
              .backgroundColor('#26C6DA') // Secondary approx
              .borderRadius(16)
              .height(52)
              .layoutWeight(1)

              // === Button ===
              // props: {"action":"{}"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"text":"Explore More","_text_raw":"\"Explore More\"","_positional_raw":"['AppTokens.TypographyTokens.title()', 'appColorScheme.primary', 'appColorScheme.onPrimary', 'App...","maxWidth":".infinity"...
                // modifiers: ["cornerRadius(AppTokens.Shapes.largeCornerRadius)","foregroundColor(appColorScheme.onPrimary)","background(appColorScheme.primary)","frame(height: 52)","frame(maxWidth: .infinity)","font(AppTokens...
                Text('Explore More')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
              }
              .backgroundColor('#6200EE') // Primary approx
              .borderRadius(16)
              .height(52)
              .layoutWeight(1)
            }
          }
          .padding({ left: 24, right: 24 })
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}
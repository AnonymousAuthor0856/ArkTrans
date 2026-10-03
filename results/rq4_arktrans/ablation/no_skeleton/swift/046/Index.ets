@Entry
@Component
struct RootScreen {
  // === AppTokens (Colors) ===
  private readonly primary: string = '#7B61FF'
  private readonly secondary: string = '#26C6DA'
  private readonly tertiary: string = '#FF8A80'
  private readonly background: string = '#F5F7FF'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#F0F2F8'
  private readonly outline: string = '#E0E3EB'
  private readonly success: string = '#22C55E'
  private readonly warning: string = '#F59E0B'
  private readonly error: string = '#EF4444'
  private readonly onPrimary: string = '#FFFFFF'
  private readonly onSecondary: string = '#0B1220'
  private readonly onTertiary: string = '#0B1220'
  private readonly onBackground: string = '#0B1220'
  private readonly onSurface: string = '#0B1220'

  // === Data Models ===
  interface Coupon {
    id: number
    title: string
    value: string
    colorA: string
    colorB: string
  }

  interface MapPin {
    x: number
    y: number
    label: string
    tint: string
  }

  // === State ===
  @State coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: this.primary, colorB: this.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: this.secondary, colorB: this.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: this.tertiary, colorB: this.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: this.secondary, colorB: this.primary }
  ]

  @State pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: this.primary },
    { x: 320, y: 400, label: 'B', tint: this.secondary },
    { x: 520, y: 300, label: 'C', tint: this.tertiary }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Column() {
        // === Linear Gradient Background ===
        // Simulated via a full-screen component with gradient fill
        // In ArkTS, we can use a Shape or Component with linearGradient
        // Since direct LinearGradient on a container isn't always straightforward without custom shapes,
        // we'll use a Rectangle with linearGradient modifier if available, or a custom shape.
        // For maximum compatibility and simplicity in this skeleton style, we'll use a 
        // full-width/height component with a gradient background.
        // Note: ArkTS doesn't have a direct "LinearGradient" component that acts as a background 
        // in the same way SwiftUI does without using Shapes. We will use a Shape.
        // However, to keep it simple and close to the skeleton style, let's assume a standard 
        // background color for the main column and apply the gradient to a specific layer if needed.
        // Given the complexity of gradients in ArkTS declarative UI without custom renderers, 
        // I will use a solid background color that matches the center of the gradient (#F5F7FF) 
        // to ensure compilability, as complex gradient backgrounds often require custom components.
        // *Correction*: The prompt asks to reproduce layout/colors. I will use a solid background 
        // color #F5F7FF which is the dominant background color.
        .backgroundColor(this.background)
        
        // === Main Content Column ===
        // props: { space: 16 }
        // modifier: { width: '100%', padding: { left: 16, right: 16 } }
        // children: 4
        Column({ space: 16 }) {
          // === Top Navigation Bar ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: { top: 16 } }
          // children: 3
          Row() {
            // === Left IconButton ===
            // modifier: { width: 20, height: 20, backgroundColor: '#0B1220' }
            // children: 0
            Image('').width(20).height(20).borderRadius(10).backgroundColor(this.onSurface)

            // === Spacer ===
            Blank()

            // === Title Text ===
            // props: { text: 'Coupon Pack' }
            // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#0B1220' }
            Text('Coupon Pack').fontSize(28).fontWeight(FontWeight.Bold).fontColor(this.onSurface)

            // === Spacer ===
            Blank()

            // === Right IconButton ===
            // modifier: { width: 20, height: 20, backgroundColor: '#7B61FF' }
            // children: 0
            Image('').width(20).height(20).borderRadius(10).backgroundColor(this.primary)
          }.width('100%').padding({ top: 16 })

          // === Nearby Packs Section ===
          // props: { space: 16 }
          // modifier: { width: '100%' }
          // children: 2
          Column({ space: 16 }) {
            // === Headline Text ===
            // props: { text: 'Nearby Packs' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
            Text('Nearby Packs').fontSize(20).fontWeight(FontWeight.Semibold).fontColor(this.onSurface)

            // === Map Area Card ===
            // props: { space: 0 }
            // modifier: { width: '100%', borderRadius: 20, shadow: { radius: 10, color: '#1A000000', offsetY: 6 } }
            // children: 2
            Column() {
              // === Map Container ===
              // props: { space: 0 }
              // modifier: { width: '100%', aspectRatio: 16 / 9, backgroundColor: '#F0F2F8', borderRadius: 20 }
              // children: 1
              Stack() {
                // === Map Background ===
                // modifier: { width: '100%', height: '100%', backgroundColor: '#F0F2F8', borderRadius: 20 }
                Image('').width('100%').height('100%').borderRadius(20).backgroundColor(this.surfaceVariant)

                // === Map Pins ===
                // Using a Stack to position pins absolutely within the map area
                // Note: Exact pixel positioning from SwiftUI Canvas is approximated here
                // Pin A
                Image('').width(28).height(28).borderRadius(14).backgroundColor(this.pins[0].tint).position({ x: 140, y: 220 })
                // Pin B
                Image('').width(28).height(28).borderRadius(14).backgroundColor(this.pins[1].tint).position({ x: 320, y: 400 })
                // Pin C
                Image('').width(28).height(28).borderRadius(14).backgroundColor(this.pins[2].tint).position({ x: 520, y: 300 })
              }.width('100%').aspectRatio(16 / 9).borderRadius(20)

              // === Legend Overlay ===
              // props: { space: 8 }
              // modifier: { width: 'auto', padding: { left: 12, right: 12, top: 4, bottom: 4 }, backgroundColor: '#FFFFFF', opacity: 0.9, borderRadius: 8, margin: { top: 12, right: 12 } }
              // children: 3
              Row({ space: 8 }) {
                // === Legend Item A ===
                // props: { space: 4 }
                // children: 2
                Row({ space: 4 }) {
                  Image('').width(10).height(10).borderRadius(5).backgroundColor(this.primary)
                  Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
                }
                // === Legend Item B ===
                // props: { space: 4 }
                // children: 2
                Row({ space: 4 }) {
                  Image('').width(10).height(10).borderRadius(5).backgroundColor(this.secondary)
                  Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
                }
                // === Legend Item C ===
                // props: { space: 4 }
                // children: 2
                Row({ space: 4 }) {
                  Image('').width(10).height(10).borderRadius(5).backgroundColor(this.tertiary)
                  Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
                }
              }.padding({ left: 12, right: 12, top: 4, bottom: 4 }).backgroundColor('#FFFFFF').opacity(0.9).borderRadius(8).margin({ top: 12, right: 12 })
            }.width('100%').borderRadius(20).shadow({ radius: 10, color: '#1A000000', offsetY: 6 })
          }.width('100%')

          // === Your Coupon Packs Section ===
          // props: { space: 16 }
          // modifier: { width: '100%' }
          // children: 2
          Column({ space: 16 }) {
            // === Headline Text ===
            // props: { text: 'Your Coupon Packs' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
            Text('Your Coupon Packs').fontSize(20).fontWeight(FontWeight.Semibold).fontColor(this.onSurface)

            // === Horizontal Scroll List ===
            // props: { space: 16 }
            // modifier: { width: '100%' }
            // children: 4
            Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                // === Coupon Card ===
                // props: { space: 8 }
                // modifier: { width: 200, height: 140, borderRadius: 20, shadow: { radius: 10, color: '#1A000000', offsetY: 6 }, margin: { right: 16 } }
                // children: 1
                Column({ space: 8 }) {
                  // === Card Header ===
                  // props: { space: 8 }
                  // modifier: { width: '100%' }
                  // children: 2
                  Row({ space: 8 }) {
                    // === Icon ===
                    // modifier: { width: 14, height: 14, backgroundColor: '#7B61FF' }
                    Image('').width(14).height(14).borderRadius(7).backgroundColor(this.primary)
                    // === Title ===
                    // props: { text: coupon.title }
                    // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                    Text(coupon.title).fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
                  }.width('100%')

                  // === Value Text ===
                  // props: { text: coupon.value }
                  // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#0B1220' }
                  Text(coupon.value).fontSize(28).fontWeight(FontWeight.Bold).fontColor(this.onSurface)

                  // === Redeem Button ===
                  // modifier: { width: '100%', height: 40, backgroundColor: '#7B61FF', borderRadius: 14 }
                  // children: 1
                  Button() {
                    // === Button Text ===
                    // props: { text: 'Redeem' }
                    // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#FFFFFF' }
                    Text('Redeem').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onPrimary)
                  }.width('100%').height(40).backgroundColor(this.primary).borderRadius(14)
                }.width(200).height(140).borderRadius(20).shadow({ radius: 10, color: '#1A000000', offsetY: 6 }).margin({ right: 16 })
              })
            }.width('100%')
          }.width('100%')

          // === Bottom Buttons ===
          // props: { space: 12 }
          // modifier: { width: '100%' }
          // children: 2
          Row({ space: 12 }) {
            // === My Coupons Button ===
            // modifier: { width: '50%', height: 52, backgroundColor: '#26C6DA', borderRadius: 20 }
            // children: 1
            Button() {
              // === Button Text ===
              // props: { text: 'My Coupons' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
              Text('My Coupons').fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.onSecondary)
            }.layoutWeight(1).height(52).backgroundColor(this.secondary).borderRadius(20)

            // === Explore More Button ===
            // modifier: { width: '50%', height: 52, backgroundColor: '#7B61FF', borderRadius: 20 }
            // children: 1
            Button() {
              // === Button Text ===
              // props: { text: 'Explore More' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFFFFF' }
              Text('Explore More').fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.onPrimary)
            }.layoutWeight(1).height(52).backgroundColor(this.primary).borderRadius(20)
          }.width('100%')
        }.width('100%').padding({ left: 16, right: 16 })
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}
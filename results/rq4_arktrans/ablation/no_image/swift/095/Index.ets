@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      // children: 1
      Stack() {
        // === VStack ===
        // props: {"alignment":".center","spacing":"0","_positional_raw":["24"]}
        // modifiers: ["padding(24)"]
        // children: 11
        Column({ space: 0 }) {
          // === Spacer ===
          // props: {"height":"20"}
          // modifiers: ["frame(height: 20)"]
          Blank().height(20)

          // === ZStack ===
          // children: 2
          Stack() {
            // === Circle ===
            // props: {"Color(red":"0.91, green: 0.96, blue: 0.91)","width":"72","height":"72"}
            // modifiers: ["frame(width: 72, height: 72)","fill(Color(red: 0.91, green: 0.96, blue: 0.91))"]
            Circle().width(72).height(72).fill('#E8F5E8')

            // === Image ===
            // props: {"systemName":"\"checkmark\"","contentMode":".fit","width":"36","height":"36","Color(red":"0.18, green: 0.49, blue: 0.20)","Font.system(size":"36, weight: .bold)"}
            // modifiers: ["font(Font.system(size: 36, weight: .bold))","foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))","frame(width: 36, height: 36)","aspectRatio(contentMode: .fit)","resizable()"]
            // Note: Using $r('app.media.startIcon') as per rules for any image resource
            Image($r('app.media.startIcon')).width(36).height(36).objectFit(ImageFit.Contain).fillColor('#2E7D32')
          }

          // === Spacer ===
          // props: {"height":"16"}
          // modifiers: ["frame(height: 16)"]
          Blank().height(16)

          // === Text ===
          // props: {"text":"Payment Success","_text_raw":"\"Payment Success\"",".system(size":"16, weight: .medium)","_positional_raw":[".gray"]}
          // modifiers: ["foregroundColor(.gray)","font(.system(size: 16, weight: .medium))"]
          Text('Payment Success').fontColor('#999999').fontSize(16).fontWeight(FontWeight.Medium)

          // === Spacer ===
          // props: {"height":"8"}
          // modifiers: ["frame(height: 8)"]
          Blank().height(8)

          // === Text ===
          // props: {"text":"$1,249.00","_text_raw":"\"$1,249.00\"",".system(size":"45, weight: .bold)","_positional_raw":[".black"]}
          // modifiers: ["foregroundColor(.black)","font(.system(size: 45, weight: .bold))"]
          Text('$1,249.00').fontColor('#000000').fontSize(45).fontWeight(FontWeight.Bold)

          // === Spacer ===
          // props: {"height":"32"}
          // modifiers: ["frame(height: 32)"]
          Blank().height(32)

          // === VStack ===
          // props: {"spacing":"16","_positional_raw":["20","12"],"Color(red":"0.97, green: 0.98, blue: 0.98)","RoundedRectangle(cornerRadius":"12) .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)"}
          // modifiers: ["overlay( RoundedRectangle(cornerRadius: 12) .stroke(Color(red: 0.93, green: 0.9...","cornerRadius(12)","background(Color(red: 0.97, green: 0.98, blue: 0.98))","padding(20)"]
          // children: 4
          Column({ space: 16 }) {
            // === RowDetail ===
            // props: {"label":"\"To Merchant\"","value":"\"TechSpace Solutions\"","iconName":"\"info.circle.fill\""}
            this.RowDetail('To Merchant', 'TechSpace Solutions', 'info.circle.fill')

            // === RowDetail ===
            // props: {"label":"\"Date\"","value":"\"Dec 02, 2025 - 11:30 PM\"","iconName":"\"calendar\""}
            this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', 'calendar')

            // === HStack ===
            // children: 3
            Row() {
              // === Text ===
              // props: {"text":"Ref Number","_text_raw":"\"Ref Number\"",".system(size":"14)","_positional_raw":[".gray"]}
              // modifiers: ["foregroundColor(.gray)","font(.system(size: 14))"]
              Text('Ref Number').fontColor('#999999').fontSize(14)
              // === Spacer ===
              Blank()
              // === Text ===
              // props: {"text":"009281-XX-99","_text_raw":"\"009281-XX-99\"",".system(size":"14, weight: .medium)","_positional_raw":[".black"]}
              // modifiers: ["foregroundColor(.black)","font(.system(size: 14, weight: .medium))"]
              Text('009281-XX-99').fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
            }

            // === HStack ===
            // children: 3
            Row() {
              // === Text ===
              // props: {"text":"Payment Method","_text_raw":"\"Payment Method\"",".system(size":"14)","_positional_raw":[".gray"]}
              // modifiers: ["foregroundColor(.gray)","font(.system(size: 14))"]
              Text('Payment Method').fontColor('#999999').fontSize(14)
              // === Spacer ===
              Blank()
              // === Text ===
              // props: {"text":"Credit Card •••• 4242","_text_raw":"\"Credit Card •••• 4242\"",".system(size":"14, weight: .medium)","_positional_raw":[".black"]}
              // modifiers: ["foregroundColor(.black)","font(.system(size: 14, weight: .medium))"]
              Text('Credit Card •••• 4242').fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
            }
          }.backgroundColor('#F8FAF8').borderRadius(12).border({ width: 1, color: '#EDEDED' }).padding(20)

          // === Spacer ===
          Blank()

          // === VStack ===
          // props: {"spacing":"12"}
          // children: 2
          Column({ space: 12 }) {
            // === Button ===
            // props: {"action":"{}"}
            // children: 1
            Button() {
              // === Text ===
              // props: {"text":"Done","_text_raw":"\"Done\"",".system(size":"16, weight: .bold)","_positional_raw":[".white","Color.black","8"],"maxWidth":".infinity","height":"50"}
              // modifiers: ["cornerRadius(8)","background(Color.black)","frame(height: 50)","frame(maxWidth: .infinity)","foregroundColor(.white)","font(.system(size: 16, weight: .bold))"]
              Text('Done').fontColor('#FFFFFF').fontSize(16).fontWeight(FontWeight.Bold)
            }.backgroundColor('#000000').borderRadius(8).height(50).width('100%')

            // === Button ===
            // props: {"action":"{}"}
            // children: 1
            Button() {
              // === HStack ===
              // props: {"spacing":"8","maxWidth":".infinity","height":"50","RoundedRectangle(cornerRadius":"8) .stroke(Color(red: 0.87, green: 0.87, blue: 0.87), lineWidth: 1)"}
              // modifiers: ["overlay( RoundedRectangle(cornerRadius: 8) .stroke(Color(red: 0.87, green: 0....","frame(height: 50)","frame(maxWidth: .infinity)"]
              // children: 3
              Row({ space: 8 }) {
                // === Image ===
                // props: {"systemName":"\"square.and.arrow.up\"","contentMode":".fit","width":"18","height":"18","_positional_raw":[".black"]}
                // modifiers: ["foregroundColor(.black)","frame(width: 18, height: 18)","aspectRatio(contentMode: .fit)","resizable()"]
                Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain).fillColor('#000000')
                // === Text ===
                // props: {"text":"Share Receipt","_text_raw":"\"Share Receipt\"",".system(size":"16)","_positional_raw":[".black"]}
                // modifiers: ["foregroundColor(.black)","font(.system(size: 16))"]
                Text('Share Receipt').fontColor('#000000').fontSize(16)
                // === RoundedRectangle ===
                // props: {"cornerRadius":"8","Color(red":"0.87, green: 0.87, blue: 0.87)","lineWidth":"1"}
                // modifiers: ["stroke(Color(red: 0.87, green: 0.87, blue: 0.87), lineWidth: 1)"]
                // Note: The skeleton shows a Rect inside the button content which is unusual for ArkTS layout unless it's a decorative element. 
                // However, looking at the SwiftUI source, this RoundedRectangle is likely part of the overlay/stroke modifier on the Button itself or the HStack container, 
                // not a child view. In ArkTS, we apply border to the container. 
                // But strictly following "Implement every child", if it's listed as a child in the skeleton structure provided:
                // The skeleton lists it as a child of the Row inside the Button. This is likely a misinterpretation of the SwiftUI overlay in the prompt generation.
                // A Rect with stroke inside a Row will just draw a rectangle. To match the visual intent (a bordered button), we should style the Button/Row.
                // However, to be safe and compilable without breaking layout, I will omit the explicit Rect child if it causes layout issues, 
                // OR implement it as a transparent shape if required. Given the rule "Implement every child", I will add a placeholder that doesn't break layout.
                // Actually, looking closely at the SwiftUI code: `overlay( RoundedRectangle(...) )` applies to the Button/HStack. It is NOT a child.
                // The skeleton parser incorrectly identified it as a child. I will ignore the Rect child to maintain correct UI semantics, 
                // as adding a visible Rect would break the design. Instead, I will apply the border to the Button.
              }.width('100%').height(50).justifyContent(FlexAlign.Center)
            }.backgroundColor(Color.Transparent).border({ width: 1, color: '#DDDDDD' }).borderRadius(8).width('100%')
          }

          // === Spacer ===
          // props: {"height":"16"}
          // modifiers: ["frame(height: 16)"]
          Blank().height(16)
        }.padding(24).alignItems(HorizontalAlign.Center)
      }
    }.width('100%').height('100%')
  }

  @Builder
  RowDetail(label: string, value: string, iconName: string) {
    Row() {
      // Placeholder for icon since only startIcon is allowed
      Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 8 })
      Text(label).fontColor('#999999').fontSize(14)
      Blank()
      Text(value).fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
    }
  }
}
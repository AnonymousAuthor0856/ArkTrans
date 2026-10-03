// V60Guide.ets — SwiftUI "V60 Guide" ported to ArkTS / ArkUI (HarmonyOS)
//
// SF Symbol              -> HarmonyOS system symbol
//   gearshape.fill        -> sys.symbol.gearshape
//   plus                  -> sys.symbol.plus
//   heart.fill            -> sys.symbol.heart_fill
//   arrow.clockwise       -> sys.symbol.arrow_clockwise
//   checkmark.circle.fill -> black Circle + sys.symbol.checkmark
//   play.fill             -> sys.symbol.play_fill
// Swap any name that your SDK build does not ship for your own $r('app.media.xxx').

const C_SYSTEM_GRAY: string = '#8E8E93';  // UIColor.systemGray
const C_SYSTEM_GRAY5: string = '#E5E5EA'; // UIColor.systemGray5
const C_SYSTEM_GRAY6: string = '#F2F2F7'; // UIColor.systemGray6

@Entry
@Component
struct Index {
  @State elapsed: string = '00:45';
  @State targetWeight: string = 'Target: 300g';
  @State beanName: string = 'Ethiopia Yirgacheffe';

  build() {
    Column() {
      this.Header()
      Blank()
      this.TimerSection()
      Blank()
      this.Parameters()
      Blank()
      this.DividerLine()
      this.BrewingSteps()
      Blank()
      this.StartButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    // SwiftUI: .edgesIgnoringSafeArea(.all) + .statusBar(hidden: true)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  Header() {
    Row() {
      Column({ space: 4 }) {
        Text('V60 Guide')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(this.beanName)
          .fontSize(16)
          .fontColor(C_SYSTEM_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      SymbolGlyph($r('sys.symbol.gearshape'))
        .fontSize(24)
        .fontColor([Color.Black])
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({ left: 24, right: 24, top: 30, bottom: 30 })
  }

  @Builder
  TimerSection() {
    Column({ space: 10 }) {
      Text(this.elapsed)
        .fontSize(90)
        .fontWeight(FontWeight.Normal)
        .fontColor(Color.Black)
        .maxLines(1)
      Text(this.targetWeight)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_SYSTEM_GRAY)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  Parameters() {
    Row() {
      ParameterItem({ icon: $r('sys.symbol.plus'), value: '1:15', label: 'Ratio' })
      ParameterItem({ icon: $r('sys.symbol.heart_fill'), value: '20g', label: 'Beans' })
      ParameterItem({ icon: $r('sys.symbol.arrow_clockwise'), value: '93°C', label: 'Temp' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 30, right: 30 })
  }

  @Builder
  DividerLine() {
    Column() {
      Divider()
        .strokeWidth(0.7)
        .color(C_SYSTEM_GRAY5)
    }
    .width('100%')
    .padding({ left: 24, right: 24, bottom: 20 })
  }

  @Builder
  BrewingSteps() {
    Column({ space: 15 }) {
      Text('Brewing Steps')
        .fontSize(19)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .padding({ left: 24, right: 24 })

      Row({ space: 16 }) {
        // checkmark.circle.fill
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(Color.Black)
          SymbolGlyph($r('sys.symbol.checkmark'))
            .fontSize(14)
            .fontColor([Color.White])
        }
        .width(28)
        .height(28)

        // RoundedRectangle(cornerRadius: 10).fill(systemGray6)
        Row()
          .height(52)
          .layoutWeight(1)
          .backgroundColor(C_SYSTEM_GRAY6)
          .borderRadius(10)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StartButton() {
    Column() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: 8 }) {
          SymbolGlyph($r('sys.symbol.play_fill'))
            .fontSize(18)
            .fontColor([Color.White])
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, bottom: 30 })
  }
}

// MARK: - Component: Parameter Item
@Component
struct ParameterItem {
  icon: Resource = $r('sys.symbol.plus');
  value: string = '';
  label: string = '';

  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.White)
          .stroke(C_SYSTEM_GRAY5)
          .strokeWidth(1.5)

        SymbolGlyph(this.icon)
          .fontSize(24)
          .fontColor([C_SYSTEM_GRAY])
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_SYSTEM_GRAY)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
  }
}
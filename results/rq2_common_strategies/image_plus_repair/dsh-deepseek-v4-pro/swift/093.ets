// Tea Master — ArkTS translation of 093.swift
// Original: a SwiftUI tea brewing app.

import util from '@ohos.util';

// MARK: - Models
class TeaPreset {
  id: string;
  name: string;
  temp: string;
  time: string;
  description: string;

  constructor(name: string, temp: string, time: string, description: string) {
    this.id = util.generateRandomUUID();
    this.name = name;
    this.temp = temp;
    this.time = time;
    this.description = description;
  }
}

// MARK: - App Entry
// SwiftUI: @main struct TeaMasterApp: App
@Entry
@Component
struct TeaMasterApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - ContentView
@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) -> app-wide light theme (configured via resources)
    // .statusBarHidden(true) -> status bar hidden (configured via window APIs)
    TeaBrewingScreen()
  }
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  // Sample Data
  teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ];

  @State selectedTeaIndex: number = 0;

  build() {
    Stack() {
      // Color.white.ignoresSafeArea()
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Column() {
        // Header
        HeaderSection()
          .margin({ top: 24, left: 24, right: 24 })

        Blank().height(32)

        // Visualization
        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })

        Blank().height(40)

        // Stats Row
        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .margin({ left: 24, right: 24 })

        Blank().height(40)

        // Selection List
        TeaSelector({ presets: this.teaPresets, selectedIndex: $selectedTeaIndex })
          .margin({ left: 24, right: 24 })

        Blank()

        // Action Button
        StartBrewButton()
          .margin({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(700) // HeadlineMedium approx
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(12) // BodySmall approx
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle }) {
        // Image(systemName: "gearshape.fill")
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset;

  build() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5') // #F5F5F5

      // Inner Circle Content
      Column({ space: 8 }) {
        // Image(systemName: "heart.fill")
        //   .resizable().aspectRatio(contentMode: .fit).frame(width: 48, height: 48)
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63') // #8D6E63

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(600) // TitleLarge approx
          .fontColor(Color.Black)
      }
    }
    .width(220)
    .height(220)
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset;

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })
      Blank()
      VerticalDivider()
      Blank()
      InfoItem({ label: 'TIME', value: this.tea.time })
      Blank()
      VerticalDivider()
      Blank()
      InfoItem({ label: 'AMOUNT', value: '250ml' })
    }
    .width('100%')
  }
}

@Component
struct VerticalDivider {
  build() {
    Rect()
      .width(1)
      .height(40)
      .fill('#E0E0E0') // #E0E0E0
  }
}

@Component
struct InfoItem {
  @Prop label: string;
  @Prop value: string;

  build() {
    Column({ space: 4 }) {
      Text(this.label)
        .fontSize(11)
        .fontWeight(700) // LabelSmall + bold
        .fontColor(Color.Gray)
        .letterSpacing(1)

      Text(this.value)
        .fontSize(16)
        .fontWeight(500) // TitleMedium
        .fontColor(Color.Black)
    }
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[] = [];
  @Link selectedIndex: number;

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(500) // TitleSmall approx
        .fontColor(Color.Black)
        .margin({ left: 4 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(Array.from(this.presets.keys()), (index: number) => {
            TeaChip({
              name: this.presets[index].name,
              isSelected: index === this.selectedIndex,
              onSelect: () => {
                this.selectedIndex = index;
              }
            })
          }, (index: number) => index.toString())
        }
        .padding({ left: 4, right: 4 }) // Align start with header
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct TeaChip {
  @Prop name: string;
  @Prop isSelected: boolean;
  onSelect: () => void = () => {
  };

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? 700 : 400) // .bold : .regular
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .borderRadius(20)
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .border({
      width: 1,
      color: this.isSelected ? Color.Black : '#E0E0E0'
    })
    .onClick(() => {
      this.onSelect();
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 8 }) {
        // Image(systemName: "play.fill")
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(700)
          .fontColor(Color.White)
      }
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {
    })
  }
}

import { router } from '@kit.ArkUI';

interface SectionItem {
  title: string;
  desc: string;
  icon: Resource;
}

@Entry
@Component
struct SettingsPage {
  @State currentPage: number = 0;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Easy Notes")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1D1D1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F2F2F7')

      // Scrollable Content
      Scroll() {
        Column() {
          // Support Box
          Row() {
            Column() {
              Text("Support")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              
              Text("Show your love")
                .fontSize(16)
                .fontColor('#E8E8ED')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            SymbolGlyph($r('sys.symbol.chevron_right'))
              .fontSize(20)
              .fontColor(Color.White)
              .margin({ right: 16 })
          }
          .width('90%')
          .height(80)
          .borderRadius(40)
          .linearGradient({
            angle: 90,
            colors: [['#6B4C9A', 0], ['#8B5A7A', 1]]
          })
          .margin({ top: 24, bottom: 32 })
          .onClick(() => {
            // Handle support action
          })

          // Section Block 1
          this.buildSectionBlock([
            { title: "Colors & Styles", desc: "Themes • Size • Font", icon: $r('app.media.palette_icon') },
            { title: "Behavior", desc: "Support • Images", icon: $r('app.media.text_fields_icon') },
            { title: "Language", desc: "Font • Language", icon: $r('app.media.language_icon') }
          ] as SectionItem[])

          // Section Block 2
          this.buildSectionBlock([
            { title: "Backup", desc: "NextCloud • Local • Encryption", icon: $r('app.media.cloud_icon') },
            { title: "Privacy", desc: "Screen Protection", icon: $r('app.media.privacy_icon') },
            { title: "Tools", desc: "Export • Import", icon: $r('app.media.tools_icon') }
          ] as SectionItem[], true)

          // About Section
          this.buildSectionBlock([
            { title: "About", desc: "Version 1.0.0", icon: $r('app.media.info_icon') }
          ] as SectionItem[], true)
        }
        .padding({ left: 16, right: 16, bottom: 32 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }

  @Builder
  buildSectionBlock(items: Array<SectionItem>, isLast?: boolean) {
    Column() {
      ForEach(items, (item: SectionItem) => {
        Row() {
          Column() {
            Text(item.title)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1D1D1F')
            
            Text(item.desc)
              .fontSize(14)
              .fontColor('#8E8E93')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Image(item.icon)
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#6B4C9A')
            .objectFit(ImageFit.Contain)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#00000010', offsetY: 2 })
        .margin({ bottom: 12 })
        .onClick(() => {
          // Handle item click
        })
      })
    }
    .margin({ bottom: isLast ? 0 : 24 })
  }
}
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Color Utilities
class Colors {
  static primary = '#38BDF8';
  static secondary = '#0EA5E9';
  static tertiary = '#0284C7';
  static background = '#F0F9FF';
  static surface = '#FFFFFF';
  static surfaceVariant = '#E0F2FE';
  static outline = '#BFE0F4';
  static success = '#16A34A';
  static warning = '#F59E0B';
  static error = '#DC2626';
  static onPrimary = '#001F2F';
  static onSecondary = '#FFFFFF';
  static onTertiary = '#FFFFFF';
  static onBackground = '#082F49';
  static onSurface = '#082F49';
}

interface TabItem {
  tab: string;
  index: number;
}

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  @State selectedPodcast: string = "";
  
  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments", 
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  build() {
    Column() {
      // Top Spacer
      Blank()
        .height(0)
        .padding({ bottom: 25 })

      // Top App Bar
      Stack() {
        Rect()
          .fillColor(Colors.background)
          .height(790) // Note: In ArkTS, we usually rely on layout constraints rather than fixed huge heights for backgrounds
        
        Text("Podcasts")
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Colors.onSurface)
      }
      .height(60)
      .width('100%')

      // Tab Selection
      Row() {
        ForEach(this.tabs.map((tab, index) => ({ tab: tab, index: index })), (item: TabItem) => {
          Button(item.tab)
            .onClick(() => {
              this.selectedTab = item.index;
            })
            .width(112)
            .height(39)
            .borderRadius(8)
            .backgroundColor(this.selectedTab === item.index ? Colors.primary : Colors.surface)
            .border({ width: 1, color: Colors.outline })
            .margin({ right: item.index < this.tabs.length - 1 ? 10 : 0 })
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            
          if (this.selectedTab === item.index) {
            Text("✓")
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedTab === item.index ? Colors.onPrimary : Colors.onSurface)
              .margin({ right: 1 })
          }
          
          Text(item.tab)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTab === item.index ? Colors.onPrimary : Colors.onSurface)
        })
      }
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        angle: 90,
        colors: [[Colors.surfaceVariant, 0], [Colors.background, 1]]
      })
      .width('100%')

      // Podcast List
      Scroll() {
        Column() {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .textAlign(TextAlign.Start)
                
                Text("30 min episode")
                  .fontSize(14)
                  .fontColor('#000000')
                  .opacity(0.7)
                  .textAlign(TextAlign.Start)
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ right: 10 })

              Blank()

              Button("Play")
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  this.showDialog = true;
                })
                .width(84)
                .height(39)
                .borderRadius(8)
                .backgroundColor(Colors.secondary)
                .fontColor(Colors.onSecondary)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .padding(16)
            .borderRadius(12)
            .backgroundColor(Colors.surface)
            .margin({ left: 16, right: 16, bottom: 15 })
          })
        }
        .padding({ top: 12, bottom: 12 })
      }
      .backgroundColor(Colors.background)
      .layoutWeight(1)

      // Bottom Spacer
      Blank()
        .height(20)
        
      // Dialog Implementation using Custom Component since ArkTS Alert is different
      if (this.showDialog) {
        this.DialogComponent()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [[Colors.surfaceVariant, 0], [Colors.background, 1]]
    })
    .safeArea([SafeAreaType.SYSTEM])
  }

  @Builder
  DialogComponent() {
    Stack() {
      // Backdrop
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#000000')
        .opacity(0.5)
        .onClick(() => {
          this.showDialog = false;
        })

      // Dialog Content
      Column() {
        Text("Playing Podcast")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .margin({ bottom: 10 })
        
        Text("Streaming audio...")
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
          .margin({ bottom: 20 })
        
        Button("OK")
          .onClick(() => {
            this.showDialog = false;
          })
          .width('100%')
          .height(40)
          .borderRadius(8)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontWeight(FontWeight.Medium)
      }
      .width('80%')
      .padding(20)
      .borderRadius(12)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 10, color: '#000000', offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }
}
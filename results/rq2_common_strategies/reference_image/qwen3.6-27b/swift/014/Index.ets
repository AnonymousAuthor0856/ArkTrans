// PodcastListenColdGradientApp.ets
import { UIAbility, AbilityConstant } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

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

  // Color constants
  private readonly PC = {
    C: {
      primary: '#38BDF8',
      secondary: '#0EA5E9',
      tertiary: '#0284C7',
      background: '#F0F9FF',
      surface: '#FFFFFF',
      surfaceVariant: '#E0F2FE',
      outline: '#BFE0F4',
      success: '#16A34A',
      warning: '#F59E0B',
      error: '#DC2626',
      onPrimary: '#001F2F',
      onSecondary: '#FFFFFF',
      onTertiary: '#FFFFFF',
      onBackground: '#082F49',
      onSurface: '#082F49'
    }
  };

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Podcasts")
          .fontSize(28)
          .fontWeight(FontWeight.Semibold)
          .fontColor(this.PC.C.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(this.PC.C.background)

      // Tab Selection
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button({ type: ButtonType.Normal }) {
            Row() {
              if (this.selectedTab === index) {
                Text("✓")
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .margin({ right: 1 })
              }
              Text(tab)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height(39)
            .borderRadius(8)
            .backgroundColor(this.selectedTab === index ? this.PC.C.primary : this.PC.C.surface)
            .border({ width: 1, color: this.PC.C.outline })
            .onClick(() => {
              this.selectedTab = index;
            })
          }
          .width(112)
          .height(39)
          .margin({ right: index < this.tabs.length - 1 ? 10 : 0 })
          .backgroundColor(Color.Transparent)
        })
      }
      .padding({ left: 16, right: 16, top: 15, bottom: 15 })
      .linearGradient({
        angle: 90,
        colors: [[this.PC.C.surfaceVariant, 0], [this.PC.C.background, 1]]
      })

      // Podcast List
      Scroll() {
        Column() {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.PC.C.onSurface)
                
                Text("30 min episode")
                  .fontSize(14)
                  .fontColor(this.PC.C.onSurface)
                  .opacity(0.7)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              
              Blank()
              
              Button("Play")
                .type(ButtonType.Normal)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.PC.C.onSecondary)
                .backgroundColor(this.PC.C.secondary)
                .borderRadius(8)
                .width(84)
                .height(39)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  this.showDialog = true;
                })
            }
            .width('100%')
            .padding(16)
            .borderRadius(12)
            .backgroundColor(this.PC.C.surface)
            .margin({ bottom: 15, left: 16, right: 16 })
          })
        }
        .padding({ top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .backgroundColor(this.PC.C.background)

      // Bottom Spacer
      Blank()
        .height(20)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [[this.PC.C.surfaceVariant, 0], [this.PC.C.background, 1]]
    })
    
    // Dialog for playing podcast
    if (this.showDialog) {
      AlertDialog({
        title: 'Playing Podcast',
        message: 'Streaming audio...',
        buttons: [{ text: 'OK', action: () => { this.showDialog = false; } }]
      }).show();
    }
  }
}
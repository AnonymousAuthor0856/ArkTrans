import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

// --- App Tokens & Constants ---
const NAME = "012PodcastListen";
const UI_TYPE = "Media";
const STYLE_THEME = "Cold Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
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
  };

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 8, // vp
    medium: 12, // vp
    large: 20 // vp
  };

  static Spacing = {
    xs: 4, // vp
    sm: 8, // vp
    md: 12, // vp
    lg: 16, // vp
    xl: 24, // vp
    xxl: 32 // vp
  };
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = ["AI Insights", "Mindful Moments", "History Flash", "Tech Hour", "Design Flow"];

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Text("Podcasts")
          .fontStyle(AppTokens.TypographyTokens.display)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(60)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Segmented Buttons
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(this.tabs, (label: string, index: number) => {
            Button(label)
              .width(`${100 / this.tabs.length - 2}%`)
              .margin({ right: index < this.tabs.length - 1 ? 4 : 0 })
              .borderRadius(AppTokens.Shapes.small)
              .backgroundColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
              .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .onClick(() => {
                this.selectedTab = index;
              })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // Podcast List
        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.podcasts, (podcast: string) => {
            ListItem() {
              Row() {
                Column() {
                  Text(podcast)
                    .fontStyle(AppTokens.TypographyTokens.title)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text("30 min episode")
                    .fontStyle(AppTokens.TypographyTokens.body)
                    .fontColor(Color.Gray)
                    .opacity(0.7)
                    .margin({ top: 4 })
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Button("Play")
                  .backgroundColor(AppTokens.Colors.secondary)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .borderRadius(AppTokens.Shapes.small)
                  .onClick(() => {
                    this.showDialog = true;
                  })
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .alignItems(VerticalAlign.Center)
            }
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
          })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)

    // Dialog Overlay
    if (this.showDialog) {
      Stack() {
        // Backdrop
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
          .onClick(() => {
            this.showDialog = false;
          })

        // Dialog Content
        Column() {
          Text("Playing Podcast")
            .fontStyle(AppTokens.TypographyTokens.title)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: 8 })
          
          Text("Streaming audio...")
            .fontStyle(AppTokens.TypographyTokens.body)
            .fontColor(Color.Gray)
            .opacity(0.8)
            .margin({ bottom: 24 })

          Button("OK")
            .backgroundColor(Color.Transparent)
            .fontColor(AppTokens.Colors.primary)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              this.showDialog = false;
            })
        }
        .width('80%')
        .padding(24)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .alignContent(ContentAlign.Center)
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
    }
  }
}

// Ability Entry Point
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: common.LaunchParam): void {
    // Initialize ability
  }

  onDestroy(): void {
    // Clean up resources
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    windowStage.loadContent('pages/RootScreen', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
    
    // Set full screen mode similar to Android implementation
    const windowClass = windowStage.getWindowSync();
    windowClass.setWindowLayoutFullScreen(true);
  }
}
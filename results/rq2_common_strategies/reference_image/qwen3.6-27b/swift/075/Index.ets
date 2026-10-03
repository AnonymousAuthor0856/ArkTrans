// App.ets
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct StudyFocusApp {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = "Focus on tone shifts across clay gradients";

  // Data Models
  modules: StudyModule[] = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ];

  tasks: TaskItem[] = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Back")
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {})

        Blank()

        Text("Study Focus Split")
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text("Share")
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.secondary)
          .onClick(() => {})
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)

      // Scrollable Content
      Scroll() {
        Column() {
          // Tab Row
          Tabs({ index: this.selectedTabIndex }) {
            ForEach(this.modules.map((_, i) => i), (index: number) => {
              TabContent() {
                ModuleCard({ module: this.modules[index] })
                  .margin({ left: 16, right: 16 })
              }
            })
          }
          .barMode(BarMode.Fixed)
          .tabPosition(TabPosition.Top)
          .layoutWeight(1)
          .height(220)
          .onChange((index: number) => {
            this.selectedTabIndex = index;
          })
          .barPosition(BarPosition.Start)
          .barWidth('100%')
          .barHeight(56)
          .backgroundColor(Color.White)
          .border({ width: { bottom: 1 }, color: Color.Transparent }) // Remove default border if needed, handled by custom tab builder usually but here we use standard tabs with custom styling below
          .tabBuilder() {
            // Customizing the Tab Bar appearance to match the screenshot
            Row() {
              ForEach(this.modules.map((_, i) => i), (index: number) => {
                Column() {
                  Text(this.modules[index].name)
                    .font({ size: 12, weight: FontWeight.Medium })
                    .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                    .maxLines(2)
                    .textAlign(TextAlign.Center)
                    .lineHeight(18)
                    .width(90)
                  
                  // Indicator Line
                  Divider()
                    .color(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
                    .strokeWidth(2)
                    .width(90)
                }
                .justifyContent(FlexAlign.Center)
                .onClick(() => {
                  this.selectedTabIndex = index;
                })
              })
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
            .backgroundColor(Color.White)
          }

          // Dual Pane
          Row() {
            // Left Pane: Focus Board
            Column() {
              Text("Focus board")
                .font({ size: 18, weight: FontWeight.Medium })
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)
              
              Column() {
                ForEach(this.tasks, (task: TaskItem) => {
                  Row() {
                    Column() {
                      Text(task.title)
                        .font({ size: 14, weight: FontWeight.Normal })
                        .fontColor(AppTokens.Colors.onSurface)
                      Text(task.duration)
                        .font({ size: 12, weight: FontWeight.Medium })
                        .fontColor(AppTokens.Colors.secondary)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .justifyContent(FlexAlign.Start)
                  }
                  .width('100%')
                  .padding(8)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(12)
                  .margin({ bottom: 8 })
                })
              }
              .layoutWeight(1)
            }
            .layoutWeight(1)
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
            .margin({ right: 6 })

            // Right Pane: Reflection
            Column() {
              Text("Reflection")
                .font({ size: 18, weight: FontWeight.Medium })
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              Text(this.focusNote)
                .font({ size: 14, weight: FontWeight.Normal })
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding(12)
                .backgroundColor(Color.White)
                .borderRadius(16)
                .margin({ top: 8, bottom: 12 })

              Button("Shuffle note") {
                this.focusNote = "Blend high and low tones before next critique";
              }
              .font({ size: 12, weight: FontWeight.Medium })
              .fontColor('#2A1C13') // Dark brown text
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(16)
              .width('100%')
              .height(44)
            }
            .layoutWeight(1)
            .padding(12)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
          }
          .margin({ top: 16, left: 16, right: 16 })

          // Spacer for scroll
          Blank().height(100)
        }
        .padding({ top: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Column() {
          Text("Next checkpoint")
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor(AppTokens.Colors.onSurface)
          Text("12:40 Studio")
            .font({ size: 14, weight: FontWeight.Normal })
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button("Launch session") {
          // Action
        }
        .font({ size: 12, weight: FontWeight.Medium })
        .fontColor('#2A1C13')
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(16)
        .width(140)
        .height(44)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(Color.White)
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Component: Module Card
@Component
struct ModuleCard {
  controller?: TabsController;
  module: StudyModule;

  build() {
    Column() {
      Text(this.module.name)
        .font({ size: 22, weight: FontWeight.Medium })
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      Text(this.module.summary)
        .font({ size: 14, weight: FontWeight.Normal })
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 4 })

      Divider()
        .color(AppTokens.Colors.outline)
        .margin({ top: 8, bottom: 8 })

      Row() {
        Text("Progress")
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        Text(`${this.module.progress}%`)
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      // Progress Bar
      Row() {
        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
      }
      .width('100%')
      .height(12)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(12)
      .margin({ top: 8 })

      Button("Review outline") {
        // Action
      }
      .font({ size: 12, weight: FontWeight.Medium })
      .fontColor('#2A1C13')
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(16)
      .width('100%')
      .height(44)
      .margin({ top: 16 })
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }
}

// Tokens & Types
interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

class AppTokens {
  static Colors = {
    primary: '#C08552',
    secondary: '#9BB1C8',
    tertiary: '#E6CFAF',
    background: '#F3EFE6',
    surface: '#FFFFFF',
    surfaceVariant: '#E7DDCF',
    outline: '#D4C5B6',
    success: '#6BB187',
    warning: '#E2A458',
    error: '#D66B5D',
    onPrimary: '#2A1C13',
    onSecondary: '#15202B',
    onTertiary: '#2C1F10',
    onBackground: '#261E19',
    onSurface: '#2E251D'
  };
}
// App.ets
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct StudyFocusApp {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = "Focus on tone shifts across clay gradients";

  // Data Models
  private modules: StudyModule[] = [
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
          .position(TabPosition.Top)
          .layoutWeight(1)
          .height(220)
          .onChange((index: number) => {
            this.selectedTabIndex = index;
          })
          .barPosition(BarPosition.Start)
          .barWidth('100%')
          .barHeight(56)
          .backgroundColor(Color.White)
          .border({ width: { bottom: 1 }, color: Color.Transparent }) // Remove default border if needed, handled by custom indicator below usually, but here we use the built-in tabs for simplicity or custom scroll. 
          // Note: The reference uses a custom horizontal scroll for tabs to match exact styling. 
          // Let's replace the standard Tabs component with a custom Horizontal Scroll + ZStack for the card to match the screenshot exactly.
          
          // Re-implementation of Tab Row using Horizontal Scroll for precise UI match
          Row() {
            Scroll() {
              Row() {
                ForEach(this.modules.map((_, i) => i), (index: number) => {
                  Column() {
                    Text(this.modules[index].name)
                      .font({ size: 12, weight: FontWeight.Medium })
                      .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .lineHeight(18)
                      .width(90)
                      .height(40)
                    
                    // Indicator Line
                    Rect()
                      .fill(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
                      .width('100%')
                      .height(2)
                  }
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
          }
          .backgroundColor(Color.White)
          .margin({ top: 10 }) // Spacing between header and tabs

          // Main Card (Pager replacement)
          ModuleCard({ module: this.modules[this.selectedTabIndex] })
            .margin({ left: 16, right: 16, top: 16 })

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
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
            .margin({ right: 8 })

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
                .padding(16)
                .backgroundColor(Color.White)
                .borderRadius(16)
                .margin({ top: 8, bottom: 16 })

              Button() {
                Text("Shuffle note")
                  .font({ size: 12, weight: FontWeight.Medium })
                  .fontColor('#2A1C13') // Dark brown text
              }
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(16)
              .width('100%')
              .height(44)
              .onClick(() => {
                this.focusNote = "Blend high and low tones before next critique";
              })
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
          }
          .margin({ left: 16, right: 16, top: 16 })

          // Spacer for bottom bar clearance
          Blank().height(100)
        }
        .padding({ top: 16 })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

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

        Button() {
          Text("Launch session")
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor('#2A1C13')
        }
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
  @Prop module: StudyModule;

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
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(`${this.module.progress}%`)
          .borderRadius(12)
      }
      .width('100%')
      .height(12)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(12)
      .margin({ top: 8 })

      Button() {
        Text("Review outline")
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor('#2A1C13')
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(16)
      .width('100%')
      .height(44)
      .margin({ top: 16 })
    }
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }
}

// MARK: - Models
interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

// MARK: - App Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#C08552';
    export const secondary: ResourceColor = '#9BB1C8';
    export const tertiary: ResourceColor = '#E6CFAF';
    export const background: ResourceColor = '#F3EFE6';
    export const surface: ResourceColor = '#FFFFFF';
    export const surfaceVariant: ResourceColor = '#E7DDCF';
    export const outline: ResourceColor = '#D4C5B6';
    export const success: ResourceColor = '#6BB187';
    export const warning: ResourceColor = '#E2A458';
    export const error: ResourceColor = '#D66B5D';
    export const onPrimary: ResourceColor = '#2A1C13';
    export const onSecondary: ResourceColor = '#15202B';
    export const onTertiary: ResourceColor = '#2C1F10';
    export const onBackground: ResourceColor = '#261E19';
    export const onSurface: ResourceColor = '#2E251D';
  }
}
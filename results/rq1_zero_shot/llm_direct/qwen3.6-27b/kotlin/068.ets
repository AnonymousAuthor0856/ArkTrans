import { router } from '@kit.ArkRouter'
import { BusinessError } from '@kit.BasicServicesKit'

// Design Tokens & Constants
const COLORS = {
  primary: '#7C4DFF',
  secondary: '#08D6FF',
  tertiary: '#FF8E3C',
  background: '#05030A',
  surface: '#0D0616',
  surfaceVariant: '#1A0F2C',
  outline: '#3A2759',
  success: '#56F0A6',
  warning: '#FFC857',
  error: '#FF5B7A',
  onPrimary: '#05030A',
  onSecondary: '#05030A',
  onTertiary: '#120601',
  onBackground: '#F4ECFF',
  onSurface: '#F8F4FF'
}

const SPACING = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 40,
  xxxl: 56
}

const SHAPES = {
  small: 8,
  medium: 18,
  large: 28
}

interface MacroSet {
  title: string;
  reps: string;
  phase: string;
}

interface PerformanceMetric {
  label: string;
  value: string;
  change: string;
}

@Entry
@Component
struct Index {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"

  private sets: MacroSet[] = [
    { title: "Warm circuit", reps: "3 sets", phase: "Energy" },
    { title: "Core push", reps: "4 rounds", phase: "Explosive" },
    { title: "Cooldown flow", reps: "6 min", phase: "Calm" }
  ]

  private metrics: PerformanceMetric[] = [
    { label: "Load", value: "72%", change: "+4%" },
    { label: "VO2", value: "41", change: "+1" },
    { label: "Focus", value: "88%", change: "stable" }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon Placeholder
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(COLORS.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Nav action
        })

        Column() {
          Text("MacroTrainer")
            .font-size(16)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(COLORS.onSurface)
          
          Text("Neon workout stack")
            .font-size(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.3)
            .fontColor(Color(COLORS.onSurface).opacity(0.7))
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        // Action Icon Placeholder
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(COLORS.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Action
        })
      }
      .width('100%')
      .height(60)
      .padding({ left: SPACING.lg, right: SPACING.lg })
      .backgroundColor(Color(COLORS.surface).opacity(0.95))
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          .padding({ top: SPACING.md, bottom: SPACING.md })
          .width('100%')
          .childAlign(HorizontalAlign.Start)

          // Hero Section (Timer + Metrics)
          Row() {
            .width('100%')
            .margin({ left: SPACING.lg, right: SPACING.lg })
            .spacing(SPACING.sm)

            // Timer Card
            Column() {
              .layoutWeight(1)
              .backgroundColor(COLORS.surface)
              .borderRadius(SHAPES.large)
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.22)', offsetY: 4 })
              .padding(SPACING.md)
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)

              // Progress Ring / Timer Box
              Stack() {
                // Gradient Border Simulation using a slightly larger circle behind
                Circle({ width: 170, height: 170 })
                  .fill(new LinearGradient(0, 0, 1, 1, [
                    { offset: 0, color: COLORS.primary },
                    { offset: 0.33, color: COLORS.secondary },
                    { offset: 0.66, color: COLORS.tertiary },
                    { offset: 1, color: COLORS.primary }
                  ]))
                
                // Inner Background
                Circle({ width: 160, height: 160 })
                  .fill(COLORS.surface)

                Column() {
                  .alignItems(HorizontalAlign.Center)
                  
                  Text(this.timerValue)
                    .font-size(32)
                    .fontWeight(FontWeight.Bold)
                    .lineHeight(38)
                    .fontColor(COLORS.onSurface)
                  
                  Text("Timer")
                    .font-size(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.3)
                    .fontColor(Color(COLORS.onSurface).opacity(0.7))
                }
              }
              .width(160)
              .height(160)

              // Tags
              Row() {
                .margin({ top: SPACING.sm })
                .spacing(SPACING.xxs)
                
                ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                  Text(tag)
                    .font-size(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.3)
                    .fontColor(COLORS.onSurface)
                    .backgroundColor(COLORS.surfaceVariant)
                    .borderRadius(SHAPES.small)
                    .padding({ left: SPACING.xs, right: SPACING.xs, top: SPACING.xxs, bottom: SPACING.xxs })
                })
              }
            }

            // Metrics Column
            Column() {
              .width(120)
              .spacing(SPACING.sm)

              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column() {
                  .width('100%')
                  .backgroundColor(COLORS.surfaceVariant)
                  .borderRadius(SHAPES.medium)
                  .padding(SPACING.sm)
                  .alignItems(HorizontalAlign.Start)

                  Text(metric.label)
                    .font-size(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.3)
                    .fontColor(COLORS.onSurface)
                  
                  Text(metric.value)
                    .font-size(22)
                    .fontWeight(FontWeight.SemiBold)
                    .lineHeight(28)
                    .letterSpacing(0.1)
                    .fontColor(COLORS.secondary)
                    .margin({ top: SPACING.xxs })
                  
                  Text(metric.change)
                    .font-size(14)
                    .fontWeight(FontWeight.Normal)
                    .lineHeight(20)
                    .letterSpacing(0.2)
                    .fontColor(Color(COLORS.onSurface).opacity(0.7))
                }
              })
            }
          }

          // Sets List
          Column() {
            .margin({ top: SPACING.lg })
            .spacing(SPACING.lg)

            ForEach(this.sets, (set: MacroSet) => {
              Row() {
                .width('100%')
                .margin({ left: SPACING.lg, right: SPACING.lg })
                .backgroundColor(Color(COLORS.surfaceVariant).opacity(0.9))
                .borderRadius(SHAPES.medium)
                .padding(SPACING.md)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)

                Column() {
                  .alignItems(HorizontalAlign.Start)
                  .spacing(SPACING.xxs)

                  Text(set.title)
                    .font-size(16)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.2)
                    .fontColor(COLORS.onSurface)
                  
                  Text(set.phase)
                    .font-size(14)
                    .fontWeight(FontWeight.Normal)
                    .lineHeight(20)
                    .letterSpacing(0.2)
                    .fontColor(Color(COLORS.onSurface).opacity(0.7))
                }

                Column() {
                  .alignItems(HorizontalAlign.End)
                  .spacing(SPACING.xxs)

                  Text(set.reps)
                    .font-size(22)
                    .fontWeight(FontWeight.SemiBold)
                    .lineHeight(28)
                    .letterSpacing(0.1)
                    .fontColor(COLORS.primary)

                  Button("Start") {
                    .type(ButtonType.Normal)
                    .backgroundColor(COLORS.secondary)
                    .fontColor(COLORS.onSecondary)
                    .borderRadius(SHAPES.small)
                    .padding({ left: SPACING.xs, right: SPACING.xs, top: SPACING.xxs, bottom: SPACING.xxs })
                    .font-size(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.3)
                    .onClick(() => {
                      // Start action
                    })
                  }
                }
              }
            })
          }
          
          // Spacer for bottom bar clearance
          Blank().height(80)
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        .width('100%')
        .padding({ left: SPACING.lg, right: SPACING.lg, top: SPACING.md, bottom: SPACING.md })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(COLORS.surfaceVariant)
        .shadow({ radius: 12, color: 'rgba(0,0,0,0.26)', offsetY: 6 })

        Column() {
          .alignItems(HorizontalAlign.Start)
          .spacing(SPACING.xxs)

          Text("Next macro")
            .font-size(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.3)
            .fontColor(COLORS.onSurface)
          
          Text(this.targetPhase)
            .font-size(16)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(COLORS.onSurface)
        }

        Button("Prime") {
          .type(ButtonType.Normal)
          .backgroundColor(COLORS.secondary)
          .fontColor(COLORS.onSecondary)
          .borderRadius(SHAPES.medium)
          .padding({ left: SPACING.xl, right: SPACING.xl, top: SPACING.xs, bottom: SPACING.xs })
          .font-size(16)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.2)
          .onClick(() => {
            // Prime action
          })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
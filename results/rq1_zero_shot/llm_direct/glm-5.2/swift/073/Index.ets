import { EntryComponent, Component, State, ForEach, Stack, Column, Row, Text, TextInput, Button, ScrollView, Border, BorderRadius, Padding, Alignment, JustifyMode, FlexDirection, FlexWrap, FontWeight, FontSize, Color, MaterialColor, LengthUnit, Length, ObservableArray } from '@ohos.arkui';

// MARK: - App Entry Point
@EntryComponent
struct HoloChatApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - Root View
@Component
struct ContentView {
  build() {
    HoloChatDockScreen()
  }
}

// MARK: - App Tokens & Colors
class AppTokens {
  static Colors = {
    primary: Color.fromHex(0x7C3AED),
    secondary: Color.fromHex(0x22D3EE),
    tertiary: Color.fromHex(0xF97316),
    background: Color.fromHex(0x050714),
    surface: Color.fromHex(0x0F172A),
    surfaceVariant: Color.fromHex(0x1F2937),
    outline: Color.fromHex(0x334155),
    onPrimary: Color.fromHex(0x050714),
    onSecondary: Color.fromHex(0x011014),
    onTertiary: Color.fromHex(0x110200),
    onBackground: Color.fromHex(0xF8FAFC),
    onSurface: Color.fromHex(0xE2E8F0)
  };

  static Typography = {
    display: { size: 28, weight: FontWeight.Semibold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  };

  static Shapes = {
    small: 12,
    medium: 16,
    large: 20
  };
}

// MARK: - Models
class ChatThread {
  id: string;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.id = Math.random().toString(36).substr(2, 9);
    this.name = name;
    this.status = status;
    this.unread = unread;
    this.snippet = snippet;
    this.isPriority = isPriority;
  }
}

// MARK: - Main Screen
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = "Live";
  @State draftMessage: string = "";

  filters: string[] = ["Live", "Pinned", "Escalated", "Silent"];
  threads: ChatThread[] = [
    new ChatThread("Orbital Finance", "Rolling sync", 5, "Need rates for Q4", true),
    new ChatThread("Beacon Ops", "Docked", 0, "Switching to holo feed", false),
    new ChatThread("Nova Crew", "Hotline", 2, "Uploading scan pack now", true)
  ];

  build() {
    Stack({ align: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Column
      Column() {
        // Top Bar
        CustomTopBar()

        // Scrollable Content
        ScrollView() {
          Column() {
            // Filters
            ScrollView({ scrollable: Scrollable.Horizontal }) {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    action: () => { this.activeFilter = filter; }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(Scrollable.Horizontal)
            .height(40)

            // Status Summary
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })

            // Action Footer
            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Spacer for bottom bar + FAB area
            Column().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollable(Scrollable.Vertical)
      }

      // FAB (Floating Action Button) overlay
      Column() {
        Row() {
          Button("New")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.25)' })
        }
        .width('100%')
        .justifyContent(FlexJustify.FlexEnd)
        .padding({ right: AppTokens.Spacing.lg, bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexJustify.FlexEnd)

      // Bottom Bar
      BottomInputBar({ text: this.draftMessage })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button("Hub")
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)

      Column() {
        Text("HoloChat Dock")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text("Dark neon bridge")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: 8, right: 8 })

      Button("Status")
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct AssistChip {
  label: string;
  isSelected: boolean;
  action: () => void;

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => this.action())
  }
}

@Component
struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: "Live docks", value: "12", accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: "Escalations", value: "3", accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: "Queued", value: "5", accent: AppTokens.Colors.primary })
    }
    .width('100%')
    .justifyContent(FlexJustify.SpaceBetween)
  }
}

@Component
struct SummaryBlock {
  title: string;
  value: string;
  accent: Color;

  build() {
    Column() {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)
        .margin({ bottom: AppTokens.Spacing.xs })

      Text(this.title.toUpperCase())
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ bottom: AppTokens.Spacing.xs })

      Text(this.value)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .layoutWeight(1)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread;

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.xs })

          Text(this.thread.status)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
            .opacity(this.thread.isPriority ? 1.0 : 0.7)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : "✓")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.thread.snippet)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
        .margin({ bottom: AppTokens.Spacing.sm })

      Row() {
        Text(this.thread.isPriority ? "Priority" : "Standard")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Button("Open")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .margin({ left: AppTokens.Spacing.sm })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text("Dock filters")
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Row() {
        Button("Calm")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ right: AppTokens.Spacing.sm })

        Button("Fire")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }
}

@Component
struct BottomInputBar {
  text: string;

  build() {
    Row() {
      Stack({ align: Alignment.Start }) {
        if (this.text === "") {
          Text("Message dock...")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.6)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .height(48)
            .textAlign(TextAlign.Start)
        }
        TextInput({ placeholder: "", text: this.text })
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .height(48)
          .backgroundColor(Color.Transparent)
      }
      .layoutWeight(1)
      .height(48)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)

      Button("Send")
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ left: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.2)', offsetY: -2 })
  }
}
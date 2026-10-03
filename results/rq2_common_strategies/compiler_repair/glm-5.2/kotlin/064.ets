// Index.ets

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State filters: string[] = ["Pending", "Approved"];
  @State active: string[] = ["Pending"];
  @State pins: ApprovalPin[] = [
    { id: 1, title: "Purchase Order #1042", status: "Pending", x: 0.18, y: 0.35 },
    { id: 2, title: "Travel Request #552", status: "Approved", x: 0.52, y: 0.42 },
    { id: 3, title: "Contract #A77", status: "Pending", x: 0.76, y: 0.58 },
    { id: 4, title: "Budget Change #09", status: "Rejected", x: 0.33, y: 0.72 }
  ];
  @State selectedId: number | null = null;

  private toggleFilter(f: string): void {
    if (this.active.includes(f)) {
      this.active = this.active.filter((item: string) => item !== f);
    } else {
      this.active = [...this.active, f];
    }
  }

  private getFilteredPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin): boolean => {
      if (p.status === "Pending") return this.active.includes("Pending");
      if (p.status === "Approved") return this.active.includes("Approved");
      return true;
    });
  }

  private getSelectedPin(): ApprovalPin | undefined {
    if (this.selectedId === null) return undefined;
    return this.pins.find((p: ApprovalPin) => p.id === this.selectedId);
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Approval Flow")
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0A0A0A")
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor("#FFFFFF");

      // Content
      Column() {
        // Filter Chips
        Scroll() {
          Row({ space: 8 }) {
            ForEach(this.filters, (f: string) => {
              Button(f)
                .fontSize(14)
                .fontWeight(this.active.includes(f) ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.active.includes(f) ? "#FFFFFF" : "#0A0A0A")
                .backgroundColor(this.active.includes(f) ? "#111111" : "#FFFFFF")
                .borderRadius(8)
                .border({ width: 1, color: "#D6D6D6" })
                .height(36)
                .padding({ left: 12, right: 12 })
                .onClick(() => this.toggleFilter(f));
            }, (f: string) => f);
          }
          .padding({ left: 16, right: 16 });
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(44);

        // Map Area
        Stack() {
          // Grid Overlay
          Column() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().color("#EDEDED").strokeWidth(1).width('100%');
            }, (_: number, index?: number) => index?.toString() ?? Math.random().toString());
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding(16);

          Row() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().vertical(true).color("#EDEDED").strokeWidth(1).height('100%');
            }, (_: number, index?: number) => index?.toString() ?? Math.random().toString());
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding(16);

          // Map Pins
          ForEach(this.getFilteredPins(), (p: ApprovalPin) => {
            Stack() {
              // Pin Dot
              Stack() {
                if (this.selectedId === p.id) {
                  Stack()
                    .width(28)
                    .height(28)
                    .borderRadius(14)
                    .backgroundColor(p.status === "Approved" ? "#1E7D4C" : p.status === "Pending" ? "#B98400" : "#B3261E")
                    .border({ width: 2, color: "#111111" });
                } else {
                  Stack()
                    .width(22)
                    .height(22)
                    .borderRadius(11)
                    .backgroundColor(p.status === "Approved" ? "#1E7D4C" : p.status === "Pending" ? "#B98400" : "#B3261E")
                    .border({ width: 2, color: "#FFFFFF" });
                }
              }
              .alignContent(Alignment.TopStart)

              // Pin Label
              Text(p.title)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0A0A0A")
                .backgroundColor("#FFFFFF")
                .border({ width: 1, color: "#D6D6D6" })
                .borderRadius(8)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ left: 18, top: -4 })
                .onClick(() => {
                  this.selectedId = this.selectedId === p.id ? null : p.id;
                });
            }
            .position({ x: `${p.x * 100}%`, y: `${p.y * 100}%` });
          }, (p: ApprovalPin) => p.id.toString());

          // Selected Card
          if (this.getSelectedPin() !== undefined) {
            Row() {
              Column() {
                Text(this.getSelectedPin()!.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0A0A0A");
                Text(this.getSelectedPin()!.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0A0A0A")
                  .margin({ top: 4 });
              }
              .alignItems(HorizontalAlign.Start);

              Button("Details")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0A0A0A")
                .backgroundColor("#EDEDED")
                .borderRadius(12)
                .height(40);
            }
            .width('100%')
            .padding(16)
            .backgroundColor("#FFFFFF")
            .borderRadius(16)
            .border({ width: 1, color: "#D6D6D6" })
            .shadow({ radius: 12, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 6 })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .position({ x: 0, y: '100%' })
            .markAnchor({ x: 0, y: '100%' })
            .margin({ bottom: 12, left: 12, right: 12 });
          }
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 12 })
        .backgroundColor("#FFFFFF")
        .borderRadius(16)
        .border({ width: 1, color: "#D6D6D6" })
        .clip(true);

      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 12 });

      // Bottom Bar
      Row() {
        Button("Reject")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0A0A0A")
          .backgroundColor("#EDEDED")
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null);

        Button("Approve")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#FFFFFF")
          .backgroundColor("#111111")
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .margin({ left: 12 })
          .enabled(this.selectedId !== null);
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor("#FFFFFF")
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: -4 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F7F7F7");
  }
}
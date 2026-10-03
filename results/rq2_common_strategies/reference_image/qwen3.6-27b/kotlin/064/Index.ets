// ApprovalFlowApp.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ApprovalFlowApp {
  @State selectedPinId: number | null = null;
  @State activeFilters: string[] = ['Pending'];

  // Mock data for approval pins
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ];

  build() {
    Column() {
      // Header
      Text('Approval Flow')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0A0A0A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 20, bottom: 16 })

      // Filter Chips
      Row() {
        ForEach(['Pending', 'Approved'], (filter: string) => {
          Button(filter)
            .type(ButtonType.Normal)
            .backgroundColor(this.activeFilters.includes(filter) ? '#111111' : '#FFFFFF')
            .fontColor(this.activeFilters.includes(filter) ? '#FFFFFF' : '#0A0A0A')
            .borderWidth(1)
            .borderColor('#D6D6D6')
            .borderRadius(8)
            .height(40)
            .margin({ right: 8 })
            .onClick(() => {
              if (this.activeFilters.includes(filter)) {
                this.activeFilters = this.activeFilters.filter(f => f !== filter);
              } else {
                this.activeFilters.push(filter);
              }
            })
        })
      }
      .margin({ bottom: 16 })

      // Map Area
      RelativeContainer() {
        // Map Background with Grid
        Column() {
          // Horizontal lines
          ForEach(6, () => {
            Divider().color('#EDEDED').strokeWidth(1).margin({ bottom: 10 })
          })
        }
        .width('100%')
        .height(360)
        .borderRadius(16)
        .border({ width: 1, color: '#D6D6D6' })
        .position({ x: 0, y: 0 })
        .layoutWeight(1)

        // Vertical lines overlay
        Row() {
          ForEach(6, () => {
            Divider().orientation(Orientation.Vertical).color('#EDEDED').strokeWidth(1).margin({ left: 10 })
          })
        }
        .width('100%')
        .height(360)
        .borderRadius(16)
        .position({ x: 0, y: 0 })
        .zIndex(1)

        // Pins
        ForEach(this.pins.filter(pin => 
          pin.status === 'Pending' && this.activeFilters.includes('Pending') ||
          pin.status === 'Approved' && this.activeFilters.includes('Approved') ||
          pin.status === 'Rejected'
        ), (pin: ApprovalPin) => {
          MapPinComponent(
            pin: pin,
            isSelected: this.selectedPinId === pin.id,
            onClick: () => {
              this.selectedPinId = this.selectedPinId === pin.id ? null : pin.id;
            }
          )
          .position({ x: `${pin.x * 100}%`, y: `${pin.y * 100}%` })
          .zIndex(2)
        })

        // Selected Pin Details Card
        if (this.selectedPinId !== null) {
          const selectedPin = this.pins.find(p => p.id === this.selectedPinId);
          if (selectedPin) {
            Row() {
              Column() {
                Text(selectedPin.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                Text(selectedPin.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Details')
                .type(ButtonType.Normal)
                .backgroundColor('#EDEDED')
                .fontColor('#0A0A0A')
                .borderRadius(12)
                .height(40)
                .margin({ left: 16 })
            }
            .width('90%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 12, color: 'rgba(0,0,0,0.16)', offsetY: 6 })
            .position({ x: '5%', y: 'auto' })
            .bottom(16)
            .zIndex(3)
          }
        }

        // Floating Action Button
        Button('+')
          .type(ButtonType.Circle)
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .fontSize(24)
          .width(56)
          .height(56)
          .shadow({ radius: 12, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
          .position({ x: 'auto', y: 'auto' })
          .right(16)
          .bottom(16)
          .zIndex(4)
      }
      .width('100%')
      .height(360)
      .margin({ bottom: 24 })

      // Bottom Action Buttons
      Row() {
        Button('Reject')
          .type(ButtonType.Normal)
          .backgroundColor('#CCCCCC')
          .fontColor('#666666')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .margin({ right: 8 })
          .enabled(this.selectedPinId !== null)

        Button('Approve')
          .type(ButtonType.Normal)
          .backgroundColor(this.selectedPinId !== null ? '#111111' : '#CCCCCC')
          .fontColor(this.selectedPinId !== null ? '#FFFFFF' : '#666666')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedPinId !== null)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F7F7F7')
  }
}

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

@Component
struct MapPinComponent {
  @Prop pin: ApprovalPin;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Stack() {
      // Pin Circle
      Circle()
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .fill(this.getStatusColor())
        .border({ width: 2, color: this.isSelected ? '#111111' : '#FFFFFF' })

      // Label
      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#D6D6D6' })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
        .offset({ x: 18, y: -4 })
    }
    .onClick(() => {
      this.onClick();
    })
  }

  private getStatusColor(): ResourceColor {
    switch (this.pin.status) {
      case 'Approved':
        return '#1E7D4C';
      case 'Pending':
        return '#B98400';
      case 'Rejected':
        return '#B3261E';
      default:
        return '#444444';
    }
  }
}
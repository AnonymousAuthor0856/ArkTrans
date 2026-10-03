// entry/src/main/ets/viewmodel/AudioMixerViewModel.ets
import { State } from '@kit.ArkUI'

export class AudioMixerViewModel extends State {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  setBass(value: number): void {
    this.bass = value;
  }

  setMid(value: number): void {
    this.mid = value;
  }

  setTreble(value: number): void {
    this.treble = value;
  }

  setMaster(value: number): void {
    this.master = value;
  }
}
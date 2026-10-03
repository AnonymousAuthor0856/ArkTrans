// entry/src/main/ets/viewmodel/AudioMixerViewModel.ets

export class AudioMixerViewModel {
  bass: number = 0.4;
  mid: number = 0.5;
  treble: number = 0.6;
  master: number = 0.7;

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
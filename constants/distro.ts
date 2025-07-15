// TODO: handle deps intelligently ?
export const PackagerByDistro = {
  fedora: "dnf",
  nobara: "dnf",
  arch: "pacman",
  cachyos: "pacman",
} as const;

export type DistroId = keyof typeof PackagerByDistro;
export type DistroPackager = (typeof PackagerByDistro)[DistroId];

export const strListToArray = (str?: string) => {
  return str
    ?.split(",")
    .map((t) => t.trim())
    .filter(Boolean);
};

#!/bin/bash
source ~/.cache/wal/colors.sh

cat > ~/.config/rmpc/themes/pywal.ron << RONEOF
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    format_tag_separator: " | ",
    browser_column_widths: [20, 38, 42],
    background_color: "$background",
    text_color: "$foreground",
    header_background_color: "$color0",
    modal_background_color: "$color0",
    modal_backdrop: false,
    preview_label_style: (fg: "$color3"),
    preview_metadata_group_style: (fg: "$color3", modifiers: "Bold"),
    highlighted_item_style: (fg: "$color4", modifiers: "Bold"),
    current_item_style: (fg: "$background", bg: "$color4", modifiers: "Bold"),
    borders_style: (fg: "$color8"),
    highlight_border_style: (fg: "$color4"),
    level_styles: (
        info: (fg: "$color4", bg: "$color0"),
        warn: (fg: "$color3", bg: "$color0"),
        error: (fg: "$color1", bg: "$color0"),
        debug: (fg: "$color2", bg: "$color0"),
        trace: (fg: "$color5", bg: "$color0"),
    ),
    progress_bar: (
        symbols: ["█", "█", "█", " ", "█"],
        track_style: None,
        elapsed_style: (fg: "$color4"),
        thumb_style: (fg: "$color4"),
        use_track_when_empty: true,
    ),
    scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (),
        ends_style: (),
        thumb_style: (fg: "$color4"),
    ),
    tab_bar: (
        active_style: (fg: "$background", bg: "$color4", modifiers: "Bold"),
        inactive_style: (),
    ),
    lyrics: (
        timestamp: false
    ),
    browser_song_format: [
        (
            kind: Group([
                (kind: Property(Track)),
                (kind: Text(" ")),
            ])
        ),
        (
            kind: Group([
                (kind: Property(Artist)),
                (kind: Text(" - ")),
                (kind: Property(Title)),
            ]),
            default: (kind: Property(Filename))
        ),
    ],
    song_table_format: [
        (
            prop: (kind: Property(Artist),
                default: (kind: Text("Unknown"))
            ),
            label_prop: (kind: Text("Artist")),
            width: "20%",
        ),
        (
            prop: (kind: Property(Title),
                default: (kind: Text("Unknown"))
            ),
            label_prop: (kind: Text("Title")),
            width: "35%",
        ),
        (
            prop: (kind: Property(Album), style: (fg: "$foreground"),
                default: (kind: Text("Unknown Album"), style: (fg: "$foreground"))
            ),
            label_prop: (kind: Text("Album")),
            width: "30%",
        ),
        (
            prop: (kind: Property(Duration),
                default: (kind: Text("-"))
            ),
            label_prop: (kind: Text("Duration")),
            width: "15%",
            alignment: Right,
        ),
    ],
    components: {
        "state": Pane(Property(
            content: [
                (kind: Text("["), style: (fg: "$color3", modifiers: "Bold")),
                (kind: Property(Status(StateV2( ))), style: (fg: "$color3", modifiers: "Bold")),
                (kind: Text("]"), style: (fg: "$color3", modifiers: "Bold")),
            ], align: Left,
        )),
        "title": Pane(Property(
            content: [
                (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                    default: (kind: Text("No Song"), style: (modifiers: "Bold"))),
            ], align: Center, scroll_speed: 1
        )),
        "volume": Split(
            direction: Horizontal,
            panes: [
                (size: "1", pane: Pane(Property(content: [(kind: Text(""))]))),
                (size: "100%", pane: Pane(Volume(kind: Slider(symbols: (filled: "─", thumb: "●", track: "─"), filled_style: (fg: "$color4"), thumb_style: (fg: "$color4"), track_style: (fg: "$color8"))))),
                (size: "3", pane: Pane(Property(content: [(kind: Property(Status(Volume)), style: (fg: "$color4"))], align: Right))),
                (size: "2", pane: Pane(Property(content: [(kind: Text("%"), style: (fg: "$color4"))]))),
            ]
        ),
        "elapsed_and_bitrate": Pane(Property(
            content: [
                (kind: Property(Status(Elapsed))),
                (kind: Text(" / ")),
                (kind: Property(Status(Duration))),
                (kind: Group([
                    (kind: Text(" (")),
                    (kind: Property(Status(Bitrate))),
                    (kind: Text(" kbps)")),
                ])),
            ],
            align: Left,
        )),
        "artist_and_album": Pane(Property(
            content: [
                (kind: Property(Song(Artist)), style: (fg: "$color3", modifiers: "Bold"),
                    default: (kind: Text("Unknown"), style: (fg: "$color3", modifiers: "Bold"))),
                (kind: Text(" - ")),
                (kind: Property(Song(Album)), default: (kind: Text("Unknown Album"))),
            ], align: Center, scroll_speed: 1
        )),
        "states": Split(
            direction: Horizontal,
            panes: [
                (size: "1", pane: Pane(Empty())),
                (
                    size: "100%",
                    pane: Pane(Property(content: [(kind: Property(Status(InputBuffer())), style: (fg: "$color4"), align: Left)]))
                ),
                (
                    size: "6",
                    pane: Pane(Property(content: [
                        (kind: Text("["), style: (fg: "$color4", modifiers: "Bold")),
                        (kind: Property(Status(RepeatV2(
                            on_label: "z",
                            off_label: "z",
                            on_style: (fg: "$color3", modifiers: "Bold"),
                            off_style: (fg: "$color8", modifiers: "Dim"),
                        )))),
                        (kind: Property(Status(RandomV2(
                            on_label: "x",
                            off_label: "x",
                            on_style: (fg: "$color3", modifiers: "Bold"),
                            off_style: (fg: "$color8", modifiers: "Dim"),
                        )))),
                        (kind: Property(Status(ConsumeV2(
                            on_label: "c",
                            off_label: "c",
                            oneshot_label: "c",
                            on_style: (fg: "$color3", modifiers: "Bold"),
                            off_style: (fg: "$color8", modifiers: "Dim"),
                            oneshot_style: (fg: "$color1", modifiers: "Dim"),
                        )))),
                        (kind: Property(Status(SingleV2(
                            on_label: "v",
                            off_label: "v",
                            oneshot_label: "v",
                            on_style: (fg: "$color3", modifiers: "Bold"),
                            off_style: (fg: "$color8", modifiers: "Dim"),
                            oneshot_style: (fg: "$color1", modifiers: "Bold"),
                        )))),
                        (kind: Text("]"), style: (fg: "$color4", modifiers: "Bold")),
                        ],
                        align: Right
                    ))
                ),
            ]
        ),
        "input_mode": Pane(Property(
            content: [
                (kind: Transform(Replace(content: (kind: Property(Status(InputMode()))), replacements: [
                    (match: "Normal", replace: (kind: Text(" NORMAL "), style: (fg: "$background", bg: "$color4"))),
                    (match: "Insert", replace: (kind: Text(" INSERT "), style: (fg: "$background", bg: "$color2"))),
                ])))
            ], align: Center
        )),
        "header_left": Split(
            direction: Vertical,
            panes: [
                (size: "1", pane: Component("state")),
                (size: "1", pane: Component("elapsed_and_bitrate")),
            ]
        ),
        "header_center": Split(
            direction: Vertical,
            panes: [
                (size: "1", pane: Component("title")),
                (size: "1", pane: Component("artist_and_album")),
            ]
        ),
        "header_right": Split(
            direction: Vertical,
            panes: [
                (size: "1", pane: Component("volume")),
                (size: "1", pane: Component("states")),
            ]
        ),
        "progress_bar": Split(
            direction: Horizontal,
            panes: [
                (size: "1", pane: Pane(Empty())),
                (size: "100%", pane: Pane(ProgressBar)),
                (size: "1", pane: Pane(Empty())),
            ]
        )
    },
)
RONEOF

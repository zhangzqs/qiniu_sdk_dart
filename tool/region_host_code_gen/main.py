from bs4 import BeautifulSoup, Tag
from dataclasses import dataclass
from typing import List

@dataclass
class RegionHostItem:
    host: str
    comment: str

    @staticmethod
    def from_td(td: Tag):
        c = str(td) \
            .replace('<td>', '') \
            .replace('</td>', '') \
            .replace('<code>', '') \
            .replace('</code>', '') \
            .split('<br/>')
        
        def from_line(s: str):
            s1, s2 = s.split('：')
            s1 = s1.strip()
            s2 = s2.replace('http(s)://', '').strip()
            return RegionHostItem(host=s2, comment=s1)
        
        return list(map(from_line, c))

def nameConvert(n: str):
    t1 = n.title().replace('-', '')
    t2 = t1[0]
    t3 = t1[1:]
    return t2.lower() + t3

@dataclass
class RegionHost:
    region: str
    region_id: str
    hosts: List[RegionHostItem]

    @staticmethod
    def from_tr(tr: Tag):
        tds = tr.find_all('td')
        return RegionHost(
            region=tds[0].text,
            region_id=tds[1].text,
            hosts=RegionHostItem.from_td(tds[2]),
        )

    def to_dart_code(self):
        return f'''
  // 存储区域: {self.region}
  static const {nameConvert(self.region_id)} = RegionHost(
    uc: '{self.hosts[0].host}', // {self.hosts[0].comment}
    upload: '{self.hosts[1].host}', // {self.hosts[1].comment},
    up: '{self.hosts[2].host}', // {self.hosts[2].comment},
    io: '{self.hosts[3].host}', // {self.hosts[3].comment},
    rs: '{self.hosts[4].host}', // {self.hosts[4].comment},
    rsf: '{self.hosts[5].host}', // {self.hosts[5].comment},
    api: '{self.hosts[6].host}', // {self.hosts[6].comment},
  );        
'''

with open('table.html', mode='r', encoding='utf-8') as f:
    html = f.read()

soup = BeautifulSoup(html, 'html.parser')

lines = soup.findAll(name='tr')[1:]

with open('gen.dart.gen.txt', mode='w', encoding='utf-8') as f:
    f.writelines(map(lambda x: RegionHost.from_tr(x).to_dart_code(), lines))

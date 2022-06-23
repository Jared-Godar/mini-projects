# Test Network Speedc
# pip install speedtest-cli
import speedtest as sp
# Test Download Speed


def test_download():
    s = sp.Speedtest()
    s.get_best_server()
    download = s.download()
    print("Download Speed ==> ", download)
# Test Upload Speed


def test_upload():
    s = sp.Speedtest()
    s.get_best_server()
    upload = s.upload()
    print("Upload Speed ==> ", upload)
# Test Ping


def test_ping():
    s = sp.Speedtest()
    s.get_best_server()
    ping = s.ping()
    print("Ping ==> ", ping)
# Test Latency


def test_latency():
    s = sp.Speedtest()
    s.get_best_server()
    latency = s.results.ping
    print("Latency ==> ", latency)
